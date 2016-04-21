//

//  CategoryRow.swift

//  Betagig

//

//  Created by Nicki on 2/26/16.

//  Copyright © 2016 shortkey. All rights reserved.

//



import Foundation

import UIKit



class CategoryRow : UITableViewCell {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var category: Category? = nil {
        didSet {
            categoryCollectionView.reloadData()
        }
    }
    
}



extension CategoryRow : UICollectionViewDataSource {
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return category!.careers.count
        
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("careerCell", forIndexPath: indexPath) as! CollectionViewCell
        
        let imgName: String = category!.careerDetails[indexPath.row].iconUrl!
        cell.pinImage.image = UIImage(named: imgName)
        cell.careerId = category!.careerDetails[indexPath.row].id
        
        cell.title.text = category!.careerDetails[indexPath.row].title
        
        var subtitle: String = ""
        let numCompanies: String = String(category!.careerDetails[indexPath.row].numBetagigs!) + " betagigs"
        let priceRange: String = "$" + String(category!.careerDetails[indexPath.row].minCost!) + "-$" + String(category!.careerDetails[indexPath.row].maxCost!)
        
        subtitle = numCompanies + ", " + priceRange
        cell.subtitle.text = subtitle
        
        return cell
        
    }
    
    
    
}



extension CategoryRow : UICollectionViewDelegateFlowLayout {
    
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        
//        let itemsPerRow:CGFloat = 3
//        
//       // let hardCodedPadding:CGFloat = 0
//        
//        let itemWidth = (collectionView.bounds.width / itemsPerRow)
//        
//        let itemHeight = collectionView.bounds.height //- (2 * hardCodedPadding)
//        
//        return CGSize(width: itemWidth, height: itemHeight)
//        
//    }
    
    
    
}