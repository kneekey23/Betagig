//
//  BrowseController.swift
//  Betagig
//
//  Created by Nicki on 2/26/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class BrowseViewController: UIViewController, UITableViewDataSource {
    
    var tableImagesOne: [String] = ["Cook", "Fireman", "Doctor", "Nurse"]
    var tableImagesTwo: [String] = ["Barber Chair", "School Director"]
    var categories: [String] = [
        "IT & Engineering",
        "Health",
        "Life Sciences",
        "Food & Agriculture",
        "Business",
        "Finance",
        "Liberal Arts",
        "Building & Construction",
        "Law Enforcement",
        "Media",
        "Sports",
        "Education",
        "Lifestyle & Personal Services"]
    var careers: [Career] = []

    override func viewDidLoad() {
        // Initialize the collection views, set the desired frames
        //grab those lists above from the database
        super.viewDidLoad()
//        if projectList == nil {
//            projectList = []
//        }
    }
    
    func refreshCareers(){
        
        let ref = Firebase(url: "https://betagig1.firebaseio.com/betagig1/careers")
        
        // Attach a closure to read the data
        ref.observeSingleEventOfType(.Value, withBlock: { snapshot in
            var careers = [Career]()
            
            for item in snapshot.children {
                let career = Career(snapshot: item as! FDataSnapshot)
                careers.append(career)
            }
            
            for c in careers {
                print(c.title)
                print(c.icon)
                print(c.category)
            }
            
            //send selectedSubjectOrCategory to db to get correct project list and popuale. then set it equal to a variable on next view controller.
            self.careers = careers
            
//            self.projectTableView.reloadData()
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! CategoryRow
        cell.category = categories[indexPath.section]
        return cell
    }
//    
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if section == 0 {
//            return tableImagesOne.count
//        }
//        else {
//            return tableImagesTwo.count
//        }
//    }
//    
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        
//        let row = indexPath.row
//        let section = indexPath.section
//        
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("careercell", forIndexPath: indexPath) as! CollectionViewCell
//        
//        if section == 0 {
//            cell.pinImage.image = UIImage(named: tableImagesOne[row])
//        }
//        else if section == 1 {
//            cell.pinImage.image = UIImage(named: tableImagesTwo[row])
//        }
//        return cell
//    }
//    
//    func collectionView(collectionView: UICollectionView,
//            layout collectionViewLayout: UICollectionViewLayout,
//            sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        return CGSize(width: 170, height: 300)
//        }
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
//        let leftRightInset = self.view.frame.size.width / 14.0
//        return UIEdgeInsetsMake(0, leftRightInset, 0, leftRightInset)
//    }
//    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        print("cell \(indexPath.section) : \(indexPath.row) selected")
//        
//        //write code to go to the next view
//    }   
    
}

