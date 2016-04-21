/*
 * Copyright 2015 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

import Foundation
import UICKeyChainStore
import AWSCore
import AWSCognito
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit
import TwitterKit
import CryptoSwift
import Alamofire
import SwiftyJSON

class AmazonCognitoManager : NSObject, GPPSignInDelegate {
    static let sharedInstance = AmazonCognitoManager()
    
    enum Provider: String {
        case FB,GOOGLE,TWITTER,BYOI
    }
    
    //KeyChain Constants
    let FB_PROVIDER = Provider.FB.rawValue
    let GOOGLE_PROVIDER = Provider.GOOGLE.rawValue
    let TWITTER_PROVIDER = Provider.TWITTER.rawValue
    let BYOI_PROVIDER = Provider.BYOI.rawValue
    
    
    //Properties
    var currentUserId: String?
    var keyChain: UICKeyChainStore
    var completionHandler: AWSContinuationBlock?
    var fbLoginManager: FBSDKLoginManager?
    var gppSignIn: GPPSignIn?
    var googleAuth: GTMOAuth2Authentication?
    var credentialsProvider: AWSCognitoCredentialsProvider?
    //var devAuthClient: DeveloperAuthenticationClient?
    var loginViewController: UIViewController?
    
    
    override init() {
        keyChain = UICKeyChainStore(service: NSBundle.mainBundle().bundleIdentifier!)
        
        super.init()
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UITabBar.appearance().tintColor = UIColor(hexString: "E65100")
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    
    // MARK: General Login    
    func resumeSession(completionHandler: AWSContinuationBlock) {
        self.completionHandler = completionHandler
        
        if self.keyChain[BYOI_PROVIDER] != nil {
            self.reloadBYOISession()
        } else if self.keyChain[FB_PROVIDER] != nil {
            self.reloadFBSession()
        } else if self.keyChain[GOOGLE_PROVIDER] != nil {
            self.reloadGSession()
        } else if self.keyChain[TWITTER_PROVIDER] != nil {
            self.twitterLogin()
        }
        
        if self.credentialsProvider == nil {
            self.completeLogin(nil)
        }
    }
    
    //Sends the appropriate URL based on login provider
    func application(application: UIApplication,
                     openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        if GPPURLHandler.handleURL(url, sourceApplication: sourceApplication, annotation: annotation) {
            return true
        }
        
        if FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation) {
            return true
        }
        
        return false
    }
    
    func completeLogin(logins: [NSObject : AnyObject]?) {
        var task: AWSTask?
        
        if self.credentialsProvider == nil {
            task = self.initializeClients(logins)
        } else {
            var merge = [NSObject : AnyObject]()
            
            //Add existing logins
            if let previousLogins = self.credentialsProvider?.logins {
                merge = previousLogins
            }
            
            //Add new logins
            if let unwrappedLogins = logins {
                for (key, value) in unwrappedLogins {
                    merge[key] = value
                }
                self.credentialsProvider?.logins = merge
            }
            //Force a refresh of credentials to see if merge is necessary
            task = self.credentialsProvider?.refresh()
        }
        task?.continueWithBlock {
            (task: AWSTask!) -> AnyObject! in
            if (task.error != nil) {
                let userDefaults = NSUserDefaults.standardUserDefaults()
                let currentDeviceToken: NSData? = userDefaults.objectForKey(Constants.DEVICE_TOKEN_KEY) as? NSData
                var currentDeviceTokenString : String
                
                if currentDeviceToken != nil {
                    currentDeviceTokenString = currentDeviceToken!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
                } else {
                    currentDeviceTokenString = ""
                }
                
                if currentDeviceToken != nil && currentDeviceTokenString != userDefaults.stringForKey(Constants.COGNITO_DEVICE_TOKEN_KEY) {
                    
                    AWSCognito.defaultCognito().registerDevice(currentDeviceToken).continueWithBlock { (task: AWSTask!) -> AnyObject! in
                        if (task.error == nil) {
                            userDefaults.setObject(currentDeviceTokenString, forKey: Constants.COGNITO_DEVICE_TOKEN_KEY)
                            userDefaults.synchronize()
                        }
                        return nil
                    }
                }
            }
            return task
            }.continueWithBlock(self.completionHandler!)
    }
    
    func initializeClients(logins: [NSObject : AnyObject]?) -> AWSTask? {
        print("Initializing Clients...")
        
        AWSLogger.defaultLogger().logLevel = AWSLogLevel.Verbose
        
        self.credentialsProvider = AWSCognitoCredentialsProvider(regionType: Constants.COGNITO_REGIONTYPE, identityPoolId:Constants.COGNITO_IDENTITY_POOL_ID)
        let configuration = AWSServiceConfiguration(region: Constants.COGNITO_REGIONTYPE, credentialsProvider: self.credentialsProvider)
        AWSServiceManager.defaultServiceManager().defaultServiceConfiguration = configuration
        
        return self.credentialsProvider?.getIdentityId()
    }
    
    func loginFromView(theViewController: UIViewController, provider: String, username: String, password: String, withCompletionHandler completionHandler: AWSContinuationBlock) {
        self.completionHandler = completionHandler
        self.loginViewController = theViewController
        
        if(provider == "facebook"){
            fbLogin()
        }
        else if provider == "twitter"{
            twitterLogin()
        }
        else if provider == "google"{
            googleLogin()
        }
        else if provider == "betagig"{
            completeBYOILogin(username, password: password)
        }
    
    }
    
    func logOut(completionHandler: AWSContinuationBlock) {
        if self.isLoggedInWithFacebook() {
            self.fbLogout()
        } else if self.isLoggedInWithGoogle() {
            self.googleLogout()
        } else if self.isLoggedInWithTwitter() {
            self.twitterLogout()
        }
        
        self.currentUserId = nil
        // Wipe credentials
        self.credentialsProvider?.logins = nil
        AWSCognito.defaultCognito().wipe()
        self.credentialsProvider?.clearKeychain()
        
        AWSTask(result: nil).continueWithBlock(completionHandler)
    }
    
    func isLoggedIn() -> Bool {
        return isLoggedInWithFacebook() || isLoggedInWithGoogle() || isLoggedInWithTwitter() || isLoggedInWithBYOI()
    }
    
    // MARK: Facebook Login
    
    func isLoggedInWithFacebook() -> Bool {
        let loggedIn = FBSDKAccessToken.currentAccessToken() != nil
        
        return self.keyChain[FB_PROVIDER] != nil && loggedIn
    }
    
    func reloadFBSession() {
        if FBSDKAccessToken.currentAccessToken() != nil {
            print("Reloading Facebook Session")
            self.completeFBLogin()
        }
    }
    
    func fbLogin() {
        if FBSDKAccessToken.currentAccessToken() != nil {
            self.completeFBLogin()
        } else {
            if self.fbLoginManager == nil {
                self.fbLoginManager = FBSDKLoginManager()
                
                fbLoginManager!.logInWithReadPermissions(["public_profile"], fromViewController: self.loginViewController, handler: {
                    (result:FBSDKLoginManagerLoginResult!,error:NSError!) in
                    
                    if error != nil {
                        dispatch_async(dispatch_get_main_queue()) {
                            self.errorAlert("Error logging in with FB: " + error.localizedDescription)
                        }
                    }
                    else if result.isCancelled {
                        NSLog("Press Cancel Button")
                    }
                    else {
                     self.getFBUserData()
                    self.completeFBLogin()
                    }
                })
            }
            }
        }
    
    
    func getFBUserData(){
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error == nil){
                   let dict: NSDictionary = result as! NSDictionary
                    print(result)
                    print(dict)
                NSLog(dict.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as! String)
                    
                    let apiUrl = "https://qc2n6qlv7g.execute-api.us-west-2.amazonaws.com/dev/user/search?id=\(dict.objectForKey("id")!)&column=facebookId&index=facebookId-index";
                    
                    Alamofire.request(.GET, apiUrl, headers: Constants.headers).validate()
                        .responseJSON { response in
                            
                            switch response.result {
                            case .Success(let data):
                                let json = JSON(data)
                                let list: Array<JSON> = json["Items"].arrayValue
                                if list.count == 0{
                                    //call database by email instead and save facebookid to user.
                                }
                                else{
                                    for l in list{
                                        let user = User(json: l)
                                        self.currentUserId = user!.id
                                    }
                                }

                            case .Failure(let error):
                                print("Request failed with error: \(error)")
                            }
                            
                    }
                    
                    
                }
            })
        }
    }
    
    func fbLogout() {
        if self.fbLoginManager == nil {
            self.fbLoginManager = FBSDKLoginManager()
        }
        self.fbLoginManager?.logOut()
        self.keyChain[FB_PROVIDER] = nil
    }
    
    func completeFBLogin() {
        self.keyChain[FB_PROVIDER] = "YES"
        self.completeLogin(["graph.facebook.com" : FBSDKAccessToken.currentAccessToken().tokenString])
    }
    
    // MARK: Google Login
    
    func isLoggedInWithGoogle() -> Bool {
        let loggedIn = self.googleAuth != nil
        return self.keyChain[GOOGLE_PROVIDER] != nil && loggedIn
    }
    
    func reloadGSession() {
        print("Reloading Google session")
        self.gppSignIn?.trySilentAuthentication()
    }
    
    func googleLogin() {
        self.gppSignIn = GPPSignIn.sharedInstance()
        self.gppSignIn?.delegate = self
        self.gppSignIn?.shouldFetchGooglePlusUser = true
        self.gppSignIn?.shouldFetchGoogleUserEmail = true  // Uncomment to get the user's email
        self.gppSignIn?.shouldFetchGoogleUserID = true
        self.gppSignIn?.clientID = Constants.GOOGLE_CLIENT_ID
        self.gppSignIn?.scopes = [Constants.GOOGLE_CLIENT_SCOPE, Constants.GOOGLE_OIDC_SCOPE, Constants.GOOGLE_CLIENT2_SCOPE]
        self.gppSignIn?.authenticate()
    }
    
    func googleLogout() {
        self.gppSignIn?.disconnect()
        self.googleAuth = nil
        self.keyChain[GOOGLE_PROVIDER] = nil
    }
    
    func finishedWithAuth(auth: GTMOAuth2Authentication!, error: NSError!) {
        if self.googleAuth == nil {
            self.googleAuth = auth;
            if (self.gppSignIn?.userID != nil){
                self.getGoogleUserData((self.gppSignIn?.userID!)!)
              
            }
            if error != nil {
                self.errorAlert("Error logging in with Google: " + error.localizedDescription)
            } else {
                self.completeGoogleLogin()
            }
        }
    }
    
    func getGoogleUserData(userId: String){
        let apiUrl = "https://qc2n6qlv7g.execute-api.us-west-2.amazonaws.com/dev/user/search?id=\(userId)&column=googleId&index=googleId-index";
        
        Alamofire.request(.GET, apiUrl, headers: Constants.headers).validate()
            .responseJSON { response in
                
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)
                    let list: Array<JSON> = json["Items"].arrayValue
                    if list.count == 0{
                        //call database by email instead and save twitterid to user.
                    }
                    else{
                        for l in list{
                            let user = User(json: l)
                            self.currentUserId = user!.id
                        }
                    }
                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                }
                
        }
    }
    
    func completeGoogleLogin() {
        self.keyChain[GOOGLE_PROVIDER] = "YES"
        if let idToken: AnyObject = self.googleAuth?.parameters.objectForKey("id_token") {
            self.completeLogin(["accounts.google.com": idToken])
        }
        
    }
    
    
    // MARK: Twitter Login / Digits Login
    
    func isLoggedInWithTwitter() -> Bool {
        let loggedIn = Twitter.sharedInstance().session() != nil
        return self.keyChain[TWITTER_PROVIDER] != nil && loggedIn
    }
    
    
    func twitterLogin() {
        print("Logging into Twitter")
        Twitter.sharedInstance().logInWithCompletion { (session, error) -> Void in
            if session != nil {
                self.getTwitterUserData((session?.userID)!)
                self.completeTwitterLogin()
            } else if error != nil{
                dispatch_async(dispatch_get_main_queue()) {
                    self.errorAlert("Error logging in with Twitter: " + error!.localizedDescription)
                }
            } else {
                self.errorAlert("Unknown Error")
            }
        }
    }
    
    func getTwitterUserData(userId: String){
        
        let apiUrl = "https://qc2n6qlv7g.execute-api.us-west-2.amazonaws.com/dev/user/search?id=\(userId)&column=twitterId&index=twitterId-index";
        
        Alamofire.request(.GET, apiUrl, headers: Constants.headers).validate()
            .responseJSON { response in
                
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)
                    let list: Array<JSON> = json["Items"].arrayValue
                    if list.count == 0{
                        //call database by email instead and save twitterid to user.
                    }
                    else{
                        for l in list{
                            let user = User(json: l)
                            self.currentUserId = user!.id
                        }
                    }
                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                }
                
        }
        
        
    }
    
    func twitterLogout() {
        Twitter.sharedInstance().logOut()
        self.keyChain[TWITTER_PROVIDER] = nil
    }
    
    func completeTwitterLogin() {
        self.keyChain[TWITTER_PROVIDER] = "YES"
        self.completeLogin(["api.twitter.com": self.loginForTwitterSession(Twitter.sharedInstance().session()!)])
    }
    
    func loginForTwitterSession(session: TWTRAuthSession) -> String {
        return session.authToken + ";" + session.authTokenSecret
    }
    
    // MARK: BYOI
    
    func isLoggedInWithBYOI() -> Bool {
        var loggedIn = false
        if currentUserId != nil{
            loggedIn = true
        }

        return (self.keyChain[BYOI_PROVIDER] != nil && loggedIn)
    }
    
    func reloadBYOISession() {
        print("Reloading Developer Authentication Session")
        self.completeLogin([Constants.DEVELOPER_AUTH_PROVIDER_NAME:self.keyChain[BYOI_PROVIDER]!])
    }
    
    
    func completeBYOILogin( username: String?, password: String?) {
        if username != nil && password != nil {
            
            let apiUrl = "https://qc2n6qlv7g.execute-api.us-west-2.amazonaws.com/dev/user/login";
           
            
            var dict : [String: AnyObject] = [:]
            dict["email"] = username!
            dict["passwordHash"] = password?.sha1()
            
            Alamofire.request(.POST, apiUrl, headers: Constants.headers, parameters: dict, encoding: .JSON).validate()
                .responseJSON { response in
                    
                    switch response.result {
                    case .Success(let data):
                        let json = JSON(data)
                        self.currentUserId = json.stringValue
                        self.keyChain[self.BYOI_PROVIDER] = self.currentUserId!
                        self.completeLogin([Constants.DEVELOPER_AUTH_PROVIDER_NAME: self.currentUserId!])
                     
                    case .Failure(let error):
                         self.errorAlert("Login failed. Check your username and password: " + error.localizedDescription)
                        print("Request failed with error: \(error)")
                    }
                    
            }
        }
    }
    
    
    
    func errorAlert(message: String) {
        let errorAlert = UIAlertController(title: "Error", message: "\(message)", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default) { (alert: UIAlertAction) -> Void in }
        
        errorAlert.addAction(okAction)
        
        self.loginViewController?.presentViewController(errorAlert, animated: true, completion: nil)
    }
}