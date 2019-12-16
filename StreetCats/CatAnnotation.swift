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
    let color: String
    let photo: UIImage
    let spot: CLLocationCoordinate2D
    let details: String?
    var isLiked: Bool
    
    func convertImageToBase64(_ image: UIImage) -> String {
        let imageData:NSData = image.jpegData(compressionQuality: 0.4)! as NSData
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        return strBase64
    }
       
    func convertBase64ToImage(_ str: String) -> UIImage {
        let dataDecoded : Data = Data(base64Encoded: str, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        return decodedimage!
    }
    
    init (title: String, color: String, photo: UIImage, spot: CLLocationCoordinate2D, coordinate: CLLocationCoordinate2D, details:String, isLiked: Bool){
        self.title = title
        self.color = color
        self.photo = photo
        self.spot = spot
        self.coordinate = coordinate
        self.details = details
        self.isLiked = isLiked

    super.init()

    }
}
