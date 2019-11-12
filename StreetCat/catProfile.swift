//
//  CatProfile.swift
//  StreetCat
//
//  Created by songji on 12/11/2019.
//  Copyright © 2019 songji. All rights reserved.
//

import UIKit

class Cat: Codable { // codable protocol 채택!
    typealias CLLocationDegrees = Double

    // Properties
    var name: String?
    var photo: UIImage?
    var age: Int?
    // var spot: CLLocationDegrees?

    // Initialization
    init?(name: String?, photo: UIImage?, age: Int?) {
        // Error: Only a failable initializer can return 'nil' -> init? 으로 수정
        // Initialize stored properties
        self.name = name
        self.photo = photo
        self.age = age

        // Initialization should fail if there is no name or if the rating is negative.
        if name!.isEmpty || age! < 0  { // !(optional): 값이 있을 수도, 없을 수도
            return nil
        }
    }

    func encode(to encoder: Encoder) throws { // encodable protocol에 필요
        var container = encoder.singleValueContainer() // required. 단일값
        try container.encode(self)
    }

    enum CodingKeys: String, CodingKey {
        case name
        case photo
        case age
    }

    func decoder() {
        
    }
    
    required init(from decoder: Decoder) throws { // decodable protocol에 필요
        let values = try decoder.container(keyedBy: CodingKeys.self) // CodingKey: enum type으로 각 case 명시
        try? self.decoder(values)
    }
}

//if let data=data, let cat1 = try? decoder.decode(Cat.self, from: data){
//        print(cat1.name)
//        print(cat1.photo)
//        print(cat1.age)
//}
//
//let encoder = JSONEncoder()
//let jsonData = try! encoder.encode()

//// 출처: Zedd (Encoding)
//let cat1 = Cat(name: "zig", photo: nil, age: 3)
//
//let encoder = JSONEncoder()
//let jsonData = try? encoder.encode(cat1) // encoding 중 에러를 발생시킬 수 있기 때문에 try 사용
//if let jsonData = jsonData, let jsonString = String(data: jsonData, encoding: .utf8){
//    print(jsonString) //{"name":"zig","age":3}
//}
//encoder.outputFormatting = .prettyPrinted
//
//// 출처: Zedd (Dedcoding)
//let decoder = JSONDecoder()
//var data = jsonString.data(using: .utf8)
//if let data = data, let myCat = try? decoder.decode(Person.self, from: data) {
//    print(myCat.name) // zig
//    print(myCat.age) // 3
//}
//

let jsonString = """
{
    "name": "Zig",
    "photo": nil,
    "age": 3
}
"""
let jsonData = jsonString.data(using: .utf8)!
let cat1 = try! JSONDecoder().decode(Cat.self, from: jsonData)
print(cat1.name ?? "defaultName")
