import UIKit

// var str = "Hello, playground"

//struct Cat: Codable { // codable protocol 채택!
//
//    typealias CLLocationDegrees = Double
//
//    var name: String
//    var character: String
//    // var photo: UIImage
//    // var spot: CLLocationDegrees
//
////    enum CodingKeys: String, CodingKey {
////       case name
////       case age
////    }
//
////    let encoder = JSONEncoder()
////    func encode(to encoder: Encoder) throws { // encodable protocol에 필요
////
////    }
////
////    let decoder = JSONDecoder()
////    init(from decoder: Decoder) throws { // decodable protocol에 필요
////        <#code#>
////    }
//
//}
//
//let jsonString = """
//{
//    "name": "zig",
//    "character": "small, little cat"
//}
//"""
//
//
//if let jsonData = jsonString.data(using: .utf8) {
//    let decoder = JSONDecoder()
//    let cat1 = try JSONDecoder().decode(Cat.self, from: jsonData)
//    print(cat1.character)
//} // 안될 경우 아래 방법 사용
//
////if let jsonData = jsonString.data(using: .utf8) {
////    let decoder = JSONDecoder()
////    do {
////        let cat1 = try JSONDecoder().decode(Cat.self, from: jsonData)
////        print(cat1.name)
////    } catch {
////        print(error.localizedDescription)
////    }
////}
//
//var cat2 = Cat(name: "yankee", character: "black, fat")
//
//let encoder = JSONEncoder()
//encoder.outputFormatting = .prettyPrinted
//
//let jsonData2 = try encoder.encode(cat2)
//let jsonString2 = String(data: jsonData2, encoding: .utf8)!
//print(jsonString2) // 안될 경우 아래 방법 사용

//do {
//    let jsonData2 = try encoder.encode(cat2)
//    if let jsonString2 = String(data: jsonData2, encoding: .utf8) {
//        print(jsonString2)
//    }
//} catch {
//    print(error.localizedDescription)
//}

//struct Cat: Codable {
//        // typealias CLLocationDegrees = Double
//    var name: String
//    var character: String
//    // var photo: UIImage
//    var spot: Double
//    }
//
//    enum DecodingError: Error {
//        case missingFile
//    }
//
////        let cat1 = Cat(name: "zig", character: "dizzy", spot: 33)
////        print(cat1.name)
//
//    guard let url = Bundle.main.url(forResource: "cats", withExtension: "json") else {
//        throw DecodingError.missingFile
//    }
//
//    let decoder = JSONDecoder()
//    let data = try Data(contentsOf: url)
//    let cat = try decoder.decode(Cat.self, from: data)
//
//    print(cat)


//func convertImageToBase64(image: UIImage) -> String {
//    let imageData = UIImagePNGRepresentation(image)!
//    return imageData.base64EncodedString(options:   Data.Base64EncodingOptions.lineLength64Characters)
//}
//
//var encoded_img = imageTobase64(image: cat1.image!)
//print(encoded_img)

//func convertImageToBase64(_ image: UIImage) -> String {
//    guard let imageData = image.jpegData(compressionQuality: 0.75) else { return "error" }
//    let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
//    return strBase64
//}
//
//let cat1 = UIImage(named: "cat1.jpeg")
//print(convertImageToBase64(cat1!))

//func base64Encoded() -> String? {
//       if let data = self.data(using: .utf8) {
//           return data.base64EncodedString()
//       }
//       return nil
//}

//func convertBase64ToImage(_ str: String) -> UIImage {
//        let dataDecoded : Data = Data(base64Encoded: str, options: .ignoreUnknownCharacters)!
//        let decodedimage = UIImage(data: dataDecoded)
//        return decodedimage!
//}

//func base64Decoded() -> String? {
//    if let data = Data(base64Encoded: self) {
//        return String(data: data, encoding: .utf8)
//    }
//    return nil
//}


extension String {
//: ### Base64 encoding a string
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }

//: ### Base64 decoding a string
    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}
var str = "Hello, playground"
print("Original string: \"\(str)\"")

if let base64Str = str.base64Encoded() {
    print("Base64 encoded string: \"\(base64Str)\"")
    if let trs = base64Str.base64Decoded() {
        print("Base64 decoded string: \"\(trs)\"")
        print("Check if base64 decoded string equals the original string: \(str == trs)")
    }
}
