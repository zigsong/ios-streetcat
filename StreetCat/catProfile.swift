//
//  CatProfile.swift
//  StreetCat
//
//  Created by songji on 12/11/2019.
//  Copyright © 2019 songji. All rights reserved.
//

import Foundation // Model은 UI와 관련이 없으므로 UIKit이 아닌 Foundation을 import

struct Cat: Codable { // codable protocol 채택
    
    typealias CLLocationDegrees = Double

    var name: String
    var character: String
    // var photo: UIImage
    var spot: (CLLocationDegrees, CLLocationDegrees)

    enum CodingKeys: String, CodingKey { // JSON에서 key는 항상 String이므로
        // key 이름 customizing. json에서 사용하는 key값이 다른 경우, case에 json key값을 부여할 수 있다.
        case name
        case character
        // case photo
        case spot
    }
    
    enum DecodingError: Error {
        case missingFile
    }
    
    init(fileName: String) throws { // 파일 안의 json data 불러오기(for decoding)
        guard let url = Bundle.main.url(forResource: "cats", withExtension: "json") else {
            // => {Current App Name}.app/파일이름.json 출력. 즉 (아마) cat.json을 불러옴
            throw DecodingError.missingFile // 위에서 DecodingError를 명시
            }
        let decoder = JSONDecoder()
        let data = try Data(contentsOf: url)
                  self = try decoder.decode(Cat.self, from: data)
                  // Cat model의 형태(type)로 decode
    }

//    let encoder = JSONEncoder() // *** encoding은 다음 시간에
//    encoder.outputFormatting = .prettyPrinted
//    func encode(to encoder: Encoder) throws { // encodable protocol에 필요 // parameter로 들어온 Encoder는 protocol name
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(name, forKey: .name)
//        try container.encode(age, forKey: .age)
//    }
    
// *** 아래의 init은 위의 파일 불러오는 init과 충돌함
//    let decoder = JSONDecoder()
    init(from decoder: Decoder) throws { // decodable protocol에 필요. JSON을 직접 decoding하는 것
        // parameter로 들어온 Decoder는 protocol name
        let container = try decoder.container(keyedBy: CodingKeys.self) // CodingKeys의 type 명시
        // decode.container: (required) 디코더에 저장된 데이터를 주어진 key type으로 변환하여 container로서 보여줌 (json을 말하는 듯)
        name = try container.decode(String.self, forKey: .name) // QQ. 소스들은 try? 사용 // 공식문서는 try 사용
        age = try container.decode(Int.self, forKey: .age)
    }
   
}

// let cat1 = try! Cat(fileName: "cat")



   
