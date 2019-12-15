//
//  DetailViewController.swift
//  StreetCats
//
//  Created by ihyemin on 02/12/2019.
//  Copyright © 2019 ihyemin. All rights reserved.


import UIKit
import MapKit

class DetailViewController: UIViewController {
    
//    var catName: String?
        
    enum DecodingError: Error {
        case missingFile
    }
    
//    var catNames: [String] = []
//    var catDetails: [String] = []
//    var catIsLiked: [Bool] = []
//    var indexOfCat = 0

    var delegate: ViewToViewDelegate?
      
    @IBOutlet weak var catNameLabel: UILabel!
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var catDetailLabel: UILabel!
    
    var cats: [CatAnnotation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let catInfo = try showData()
            print("catInfo: \(catInfo)")
//            cats = []
//            for cat in catList.cats {
//                print("\(cat.name)")
//            }
            
            catNameLabel.text = catInfo.name
            catImage.image = convertBase64ToImage(catInfo.photo!)
            // likeButton.isSelected ==
            catDetailLabel.text = catInfo.details
            
//            catNameLabel.text = catNames[indexOfCat]
//            catDetailLabel.text = catDetails[indexOfCat]
//            likeButton.isSelected = catIsLiked[indexOfCat]
        }
        catch {
            print(error)
        }
    }

    func showData() throws -> Cat {
    //        guard let url = Bundle.main.url(forResource: "cats", withExtension: "json") else {
    //           throw DecodingError.missingFile
    //        }
            
    //        do {
                // let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    //            let documentURL = FileManager.default
    //            let path = documentURL.urls(for: .documentDirectory, in: .userDomainMask)[0]
    //            let data = documentURL.contents(atPath: "savedCats.json") // retun type: Data
                
    //        }
    //        catch {
    //            print(error.localizedDescription)
    //        }
           
        let fileManager = FileManager.default // filemanager 인스턴스 생성
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0] // path 작성
        let fileURL = documentsURL.appendingPathComponent("savedCats.json")
        
        let jsonString = try Data(contentsOf: fileURL)
        // print("jsonString: \(jsonString)") // -> return 370972 bytes
        let decoder = JSONDecoder()
//        let data = try Data(contentsOf: fileURL)
        let result = try decoder.decode(Cat.self, from: jsonString)
        // print(result)
        return result
            
    }
      
    func convertBase64ToImage(_ str: String) -> UIImage {
        let dataDecoded : Data = Data(base64Encoded: str, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        return decodedimage!
    }


    @IBAction func returnToMap(_ sender: UIButton) {
        
        // delegate?.isLikedSent(catIsLiked)
        self.dismiss(animated: true, completion: nil)
    }
    
//    @IBAction func likeButtonTapped(_ sender: UIButton) {
//        if likeButton.isSelected == true {
//            likeButton.isSelected = false
//            catIsLiked[indexOfCat] = false
//            //isLiked = false
//        } else {
//            likeButton.isSelected = true
//            catIsLiked[indexOfCat] = true
//            //isLiked = true
//        }
//    }
}

