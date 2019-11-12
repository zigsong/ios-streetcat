//
//  CatProfile.swift
//  StreetCat
//
//  Created by songji on 09/11/2019.
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
        if name!.isEmpty || age! < 0  { // !: 값이 있을 수도, 없을 수도 있음
            return nil
        }
    }
    
    func encode(to encoder: Encoder) throws { // Codable-Encode protocol
        if let jsonData = jsonData, let jsonString = String(data: jsonData, encoding: .utf8){
            print(jsonString) // {"name":"zig","age":3}
        }

    };

    required init(from decoder: Decoder) throws { // Codable-Decode protocol
        let values = try decoder.container(keyedBy: CodingKeys.self)
        try? self.decoder(values)
    }
}

let encoder = JSONEncoder()
let decoder = JSONDecoder()

let cat1 = Cat(name: "zig", photo: nil, age: 3)
let cat2 = Cat(name: "yes", photo: nil, age: 5)


let cat3 = """
{
    "a": "aa",
    "b": "bb"
}
""".data(using: .utf8)! // 강제 unwrapping

let sample1 = try! JSONDecoder().decode(Cat.self, from: cat3)
print(sample1) // Sample1(a: "aa", b: "bb")

