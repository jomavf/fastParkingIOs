//
//  Place.swift
//  fastparking
//
//  Created by Jose Veliz on 6/6/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import UIKit
import MapKit

class Place: NSObject,MKAnnotation {
    var title:String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title:String,coordinate:CLLocationCoordinate2D,info:String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
