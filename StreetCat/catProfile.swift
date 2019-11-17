//
//  CatProfile.swift
//  StreetCat
//
//  Created by songji on 12/11/2019.
//  Copyright © 2019 songji. All rights reserved.
//

import Foundation // Model은 UI와 관련이 없으므로 UIKit이 아닌 Foundation을 import

struct Cat: Codable { // codable protocol 채택!
    
    typealias CLLocationDegrees = Double

    var name: String
    var age: Int
    // var photo: UIImage
    // var spot: CLLocationDegrees

    enum CodingKeys: String, CodingKey {
        // key 이름 customizing. json에서 사용하는 key값이 다른 경우, case에 json key값을 부여할 수 있다.
        case name
        case age
    }
    
    let encoder = JSONEncoder()
    func encode(to encoder: Encoder) throws { // encodable protocol에 필요
//        let encoder = JSONEncoder()
//        encoder.outputFormatting = .prettyPrinted
        // QQ. struct 안에서 encode func을 구현하는 방법은?

    }
    
    let decoder = JSONDecoder()
    init(from decoder: Decoder) throws { // decodable protocol에 필요. JSON을 직접 decoding하는 것
        let profile = try decoder.container(keyedBy: CodingKeys.self) // CodingKeys의 type 명시
        // decode.container: (required) 디코더에 저장된 데이터를 주어진 key type으로 변환하여 container로서 보여줌 (json을 말하는 듯)
        name = try! profile.decode(String.self, forKey: .name) // QQ. 소스들은 try? 사용
        age = try! profile.decode(Int.self, forKey: .age)
    }

}



   
