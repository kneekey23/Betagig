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
        
        let imgName: String = category!.careerDetails[indexPath.row]!.icon
        cell.pinImage.image = UIImage(named: imgName)
        
        cell.title.text = category!.careerDetails[indexPath.row]!.title
        
//        var subtitle: String = ""
//        let numCompanies: String = String(category!.careers.count) + " betagigs"
//        let priceRange: String = ""
//        var min = 0
//        var max = 0
//        for career in category!.careers {
//            
//        }
//        
//        subtitle = numCompanies + ", " + priceRange
//        cell.subtitle.text = subtitle
        
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