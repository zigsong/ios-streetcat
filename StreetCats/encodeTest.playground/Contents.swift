import UIKit

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

let cat1 = UIImage(named: "cat1")

convertImageToBase64(cat1)

//convertImageToBase64(cat1!)

//print("test")
