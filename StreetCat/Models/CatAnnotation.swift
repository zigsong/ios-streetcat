//  cat.swift
//  mapview
//
//  Created by ihyemin on 24/11/2019.
//  Copyright © 2019 ihyemin. All rights reserved.
//
//import Foundation
//import MapKit
//
//class Cat: NSObject, MKAnnotation {
//  let title: String?
//  let locationName: String
//  let discipline: String
//  let coordinate: CLLocationCoordinate2D
//
//  init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
//    self.title = title
//    self.locationName = locationName
//    self.discipline = discipline
//    self.coordinate = coordinate
//
//    super.init()
//  }
//
//  var subtitle: String? {
//    return locationName
//  }
//}
import UIKit
import MapKit

//enum CatColor {
//    case white
//    case black
//    case orange
//}
class CatAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
//    var subtitle: String?
    let color: String
    let spot: CLLocationCoordinate2D
    
    init(title: String, color: String,spot: CLLocationCoordinate2D, coordinate: CLLocationCoordinate2D){
        self.title = title
        self.color = color
        self.spot = spot
        self.coordinate = coordinate

    super.init()

    }
}
//
//class CatAnnotations: NSObject {
//    var cats: [CatAnnotation]
//
//    override init() {
//       //build an array of cat loactions
//        cats = [CatAnnotation(37.527658, 126.893518, title: "나루", catColor: .black)]
//        cats += [CatAnnotation(37.527360, 126.899622, title: "호두", catColor: .white)]
//        cats += [CatAnnotation(37.522153, 126.899536, title: "땅콩", catColor: .orange)]
//    }
//}
