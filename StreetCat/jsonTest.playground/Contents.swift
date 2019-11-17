import UIKit

var str = "Hello, playground"

struct Cat: Codable { // codable protocol 채택!
    
    typealias CLLocationDegrees = Double

    var name: String
    var age: Int
    // var photo: UIImage
    // var spot: CLLocationDegrees
    
//    enum CodingKeys: String, CodingKey {
//       case name
//       case age
//    }

//    let encoder = JSONEncoder()
//    func encode(to encoder: Encoder) throws { // encodable protocol에 필요
//
//    }
//
//    let decoder = JSONDecoder()
//    init(from decoder: Decoder) throws { // decodable protocol에 필요
//        <#code#>
//    }

}

let jsonString = """
{
    "name": "zig",
    "age": 3
}
"""


if let jsonData = jsonString.data(using: .utf8) {
    let decoder = JSONDecoder()
    let cat1 = try JSONDecoder().decode(Cat.self, from: jsonData)
    print(cat1.name)
} // 안될 경우 아래 방법 사용

//if let jsonData = jsonString.data(using: .utf8) {
//    let decoder = JSONDecoder()
//    do {
//        let cat1 = try JSONDecoder().decode(Cat.self, from: jsonData)
//        print(cat1.name)
//    } catch {
//        print(error.localizedDescription)
//    }
//}

var cat2 = Cat(name: "yankee", age: 4)

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted

let jsonData2 = try encoder.encode(cat2)
let jsonString2 = String(data: jsonData2, encoding: .utf8)!
print(jsonString2) // 안될 경우 아래 방법 사용

//do {
//    let jsonData2 = try encoder.encode(cat2)
//    if let jsonString2 = String(data: jsonData2, encoding: .utf8) {
//        print(jsonString2)
//    }
//} catch {
//    print(error.localizedDescription)
//}
