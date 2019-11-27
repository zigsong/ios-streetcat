//
//  CatAnnotation.swift
//  StreetCat
//
//  Created by songji on 26/11/2019.
//  Copyright © 2019 songji. All rights reserved.
//

import Foundation
import MapKit
import Contacts // dict-key constants를 보여줌

class CatAnnotation: NSObject, MKAnnotation {
    // MKAannotation이 NSObjectProtocol에 종속, 따라서 둘 다 채택
    var coordinate: CLLocationCoordinate2D
    let title: String?
    let color: String
    let spot: CLLocationCoordinate2D
      
    init(title: String, color: String, spot: CLLocationCoordinate2D, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.color = color
        self.spot = spot
        self.coordinate = coordinate
        
    super.init()
        
    
  }
  
//  var subtitle: String? {
//    return name
//  }
}

