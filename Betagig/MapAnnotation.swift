//
//  MapAnnotation.swift
//  Betagig
//
//  Created by Melissa Hargis on 3/3/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class MapAnnotation: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
