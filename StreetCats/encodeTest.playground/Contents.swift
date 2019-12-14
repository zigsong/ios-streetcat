import UIKit

struct Cat : Codable {
    var name : String
    var color : String
    var isLike: Bool
}

let encoder = JSONEncoder()

encoder.outputFormatting = [.sortedKeys, .prettyPrinted]

let cat1 = Cat(name: "Zig", color: "brown", isLike: false)

let jsonData = try? encoder.encode(cat1)

if let jsonData = jsonData, let jsonString = String(data: jsonData, encoding: .utf8){
    print(jsonString)
}

