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
    var categories: [String] = ["Blue Collar Jobs", "White collar jobs"]
    

    override func viewDidLoad() {
        // Initialize the collection views, set the desired frames
        //grab those lists above from the database

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

