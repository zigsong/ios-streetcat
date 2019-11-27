//
//  CatProfile.swift
//  mapview
//
//  Created by ihyemin on 27/11/2019.
//  Copyright © 2019 ihyemin. All rights reserved.
//

import Foundation // Model은 UI와 관련이 없으므로 UIKit이 아닌 Foundation을 import
import CoreLocation
import MapKit

struct Cat: Codable { // codable protocol 채택
    
    // var coordinate: CLLocationCoordinate2D // MKAnnotation 준수
    var name: String
    var color: String
    // var photo: String?
    var spot: CLLocation

    struct LatLon: Codable {
        var lat: Double
        var lon: Double
    }
    
    enum CodingKeys: String, CodingKey { // JSON에서 key는 항상 String이므로
        // key 이름 customizing. json에서 사용하는 key값이 다른 경우, case에 json key값을 부여할 수 있다.
        case name
        case color
        // case photo
        case spot
    }

    init(from decoder: Decoder) throws { // decodable protocol에 필요. JSON을 직접 decoding하는 것
        // parameter로 들어온 Decoder는 protocol name
        let container = try decoder.container(keyedBy: CodingKeys.self) // CodingKeys의 type 명시
        // decode.container: (required) 디코더에 저장된 데이터를 주어진 key type으로 변환하여 container로서 보여줌 (json을 말하는 듯)
        name = try container.decode(String.self, forKey: .name) // QQ. 소스들은 try? 사용 // 공식문서는 try 사용
        color = try container.decode(String.self, forKey: .color)
        // photo = try container.decode(String.self, forKey: .photo)
        let latLon = try container.decode(LatLon.self, forKey: .spot)
        spot = CLLocation(latitude: latLon.lat, longitude: latLon.lon)
        
    }
    
    func encode(to encoder: Encoder) throws { // encodable protocol에 필요 // parameter로 들어온 Encoder는 protocol name
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(color, forKey: .color)
        // try container.encode(photo, forKey: .photo)
        let latLon = LatLon(lat: spot.coordinate.latitude, lon: spot.coordinate.longitude)
        try container.encode(latLon, forKey: .spot)
    }
}

struct CatList: Codable {
    var cats: [Cat]// 여러 마리 array로 변환
}


   
