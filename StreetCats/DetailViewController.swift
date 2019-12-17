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

    var delegate: ViewToViewDelegate?
    var cats: [CatAnnotation] = []
    var indexOfCat = 0
      
    @IBOutlet weak var catNameLabel: UILabel!
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var catDetailLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()

            catNameLabel.text = cats[indexOfCat].title
            catDetailLabel.text = cats[indexOfCat].details
            likeButton.isSelected = cats[indexOfCat].isLiked
            catImage.image = cats[indexOfCat].photo

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
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        if likeButton.isSelected == true {
            likeButton.isSelected = false
            cats[indexOfCat].isLiked = false
            //isLiked = false
        } else {
            likeButton.isSelected = true
            cats[indexOfCat].isLiked = true
            //isLiked = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.isLikedSent(cats)
    }
}
