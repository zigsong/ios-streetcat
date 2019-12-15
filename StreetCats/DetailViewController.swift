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
    
    var catNames: [String] = []
    var catDetails: [String] = []
    var catIsLiked: [Bool] = []
    var indexOfCat = 0

    var delegate: ViewToViewDelegate?
    
      
    @IBOutlet weak var catNameLabel: UILabel!
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var catDetailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // json에서 해당 고양이의 정보(이름, 장소, 이미지, 상세 정보 등)를 decoding.
                 
        // cats.json의 spot이 터치된 coordinates와 같을 경우에 그 해당 json 프로퍼티들을 가져옴.
        
        // catNameLabel을 json의 name 프로퍼티로 받기....?를 다른 과정으로 구현해놨습니다.
        catNameLabel.text = catNames[indexOfCat]
        catDetailLabel.text = catDetails[indexOfCat]
        likeButton.isSelected = catIsLiked[indexOfCat]
        
        // 나머지 및 details도 받아오기.
    }
    
    // 수정하기 버튼도 추가하는 게 좋을 지는 모르겠네요. 사람마다 입력하고 싶어하는 정보가 다 다를 것 같아서 가장 먼저 등록한 사람이 그 고양이의 주인이 되는 느낌으로.. 하면 될까 싶습니다.
    
    @IBAction func returnToMap(_ sender: UIButton) {
        
        delegate?.isLikedSent(catIsLiked)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        if likeButton.isSelected == true {
            likeButton.isSelected = false
            catIsLiked[indexOfCat] = false
            //isLiked = false
        } else {
            likeButton.isSelected = true
            catIsLiked[indexOfCat] = true
            //isLiked = true
        }
    }
}

