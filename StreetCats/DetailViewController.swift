//
//  DetailViewController.swift
//  StreetCats
//
//  Created by ihyemin on 02/12/2019.
//  Copyright © 2019 ihyemin. All rights reserved.


import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    enum DecodingError: Error {
        case missingFile
    }
    
    var delegate: ViewToViewDelegate?
    var cats: [CatAnnotation] = []
    var indexOfCat = 0
    
    @IBOutlet weak var catNameLabel: UILabel!
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var catDetailLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // json에서 해당 고양이의 정보(이름, 장소, 이미지, 상세 정보 등)를 decoding.
                 
        // cats.json의 spot이 터치된 coordinates와 같을 경우에 그 해당 json 프로퍼티들을 가져옴.
        
        catNameLabel.text = cats[indexOfCat].title
        catDetailLabel.text = cats[indexOfCat].details
        likeButton.isSelected = cats[indexOfCat].isLiked
    }
        
    @IBAction func returnToMap(_ sender: UIButton) {
        
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

