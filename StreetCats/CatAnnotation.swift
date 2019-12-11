//
//  CatAnnotation.swift
//  StreetCats
//
//  Created by ihyemin on 02/12/2019.
//  Copyright © 2019 ihyemin. All rights reserved.
//


import UIKit
import MapKit

class CatAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
//    var subtitle: String?
    let color: String
    let spot: CLLocationCoordinate2D
    let details: String?
    var isLiked: Bool
    
    init (title: String, color: String, spot: CLLocationCoordinate2D, coordinate: CLLocationCoordinate2D, details:String, isLiked: Bool){
        self.title = title
        self.color = color
        self.spot = spot
        self.coordinate = coordinate
        self.details = details
        self.isLiked = isLiked

    super.init()

    }
}
