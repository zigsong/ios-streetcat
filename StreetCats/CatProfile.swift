//
//  CatProfile.swift
//  StreetCats
//
//  Created by ihyemin on 02/12/2019.
//  Copyright © 2019 ihyemin. All rights reserved.
//


import Foundation // Model은 UI와 관련이 없으므로 UIKit이 아닌 Foundation을 import
import CoreLocation
import MapKit

struct Cat: Codable { // codable protocol 채택
    
    // var coordinate: CLLocationCoordinate2D // MKAnnotation 준수
    var name: String
    var color: String
    var photo: String? // newCat으로 들어온 UIImage는 struct Cat-init의 convert를 거쳐 String으로 저장됨
    var spot: CLLocation
    var details: String
    var isLiked: Bool

    struct LatLon: Codable {
        var lat: Double
        var lon: Double
    }
    
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

    init(name: String, color: String, photo: String, spot: CLLocation, details: String, isLiked: Bool) {
        self.name = name
        self.color = color
        self.photo = photo // struct Cat의 photo property는 String(base64)로 저장됨
        self.spot = spot
        self.details = details
        self.isLiked = isLiked
    }
    
    enum CodingKeys: String, CodingKey { // JSON에서 key는 항상 String이므로
        // key 이름 customizing. json에서 사용하는 key값이 다른 경우, case에 json key값을 부여할 수 있다.
        case name
        case color
        case photo = "photo"
        case spot
        case details
        case isLiked
    }

    // try decoder.decode(Cat.self, from: data)에서 사용되는 init
    init(from decoder: Decoder) throws { // decodable protocol에 필요. JSON을 직접 decoding하는 것
        // parameter로 들어온 Decoder는 protocol name
        let container = try decoder.container(keyedBy: CodingKeys.self) // CodingKeys의 type 명시
        // decode.container: (required) 디코더에 저장된 데이터를 주어진 key type으로 변환하여 container로서 보여줌 (json을 말하는 듯)
        name = try container.decode(String.self, forKey: .name) // QQ. 소스들은 try? 사용 // 공식문서는 try 사용
        color = try container.decode(String.self, forKey: .color)
        photo = try container.decode(String.self, forKey: .photo)
        let latLon = try container.decode(LatLon.self, forKey: .spot)
        spot = CLLocation(latitude: latLon.lat, longitude: latLon.lon)
        details = try container.decode(String.self, forKey: .details)
        isLiked = try container.decode(Bool.self, forKey: .isLiked)
        
    }
    
    // var cat = Cat(~~) -> encoder.encode(cat)에서 필요
    func encode(to encoder: Encoder) throws { // encodable protocol에 필요 // parameter로 들어온 Encoder는 protocol name
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(color, forKey: .color)
        try container.encode(photo, forKey: .photo)
        let latLon = LatLon(lat: spot.coordinate.latitude, lon: spot.coordinate.longitude)
        try container.encode(latLon, forKey: .spot)
        try container.encode(details, forKey: .details)
        try container.encode(isLiked, forKey: .isLiked)
    }

}

struct CatList: Codable {
    var cats: [Cat]
    
    mutating func addCat(_cat: Cat) {
        // cats에 새로운 길냥이 추가
    }

    
}


   
