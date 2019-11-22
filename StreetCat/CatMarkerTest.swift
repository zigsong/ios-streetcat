//
//  CatMarkerTest.swift
//  StreetCat
//
//  Created by 배주영 on 2019/11/19.
//  Copyright © 2019 songji. All rights reserved.
//

import UIKit
import MapKit

enum CatColor {
    case white
    case black
    case orange
}

class CatAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    //var subtitle: String?
    var catColor: CatColor
    init(_ latitude:CLLocationDegrees,_ longitude:CLLocationDegrees,title:String,catColor:CatColor){
        self.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        self.title = title
        self.catColor = catColor
    }
}

class CatAnnotations: NSObject {
    var cats: [CatAnnotation]
    
    override init() {
       //build an array of cat loactions
        cats = [CatAnnotation(37.527658, 126.893518, title: "나루", catColor: .black)]
        cats += [CatAnnotation(37.527360, 126.899622, title: "호두", catColor: .white)]
        cats += [CatAnnotation(37.522153, 126.899536, title: "땅콩", catColor: .orange)]
    }
}
