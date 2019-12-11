//
//  DetailViewController.swift
//  StreetCats
//
//  Created by ihyemin on 02/12/2019.
//  Copyright © 2019 ihyemin. All rights reserved.


import UIKit


class DetailViewController: UIViewController {
    var catName: String?
      
    @IBOutlet weak var catNameLabel: UILabel!
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
      
    override func viewDidLoad() {
        super.viewDidLoad()
        // json에서 해당 고양이의 정보(이름, 장소, 이미지, 상세 정보)를 decoding.
        
        
        // catNameLabel.text = catName
        //  catImage.image = #imageLiteral(resourceName: "cat1")
    }

    
      // 수정하기 버튼도 추가하는 게 좋을 지는 모르겠네요. 사람마다 입력하고 싶어하는 정보가 다 다를 것 같아서 가장 먼저 등록한 사람이 그 고양이의 주인이 되는 느낌으로.. 하면 될까 싶습니다.
      
      @IBAction func returnToMap(_ sender: UIButton) {
          self.dismiss(animated: true, completion: nil)
      }

    @IBAction func likeButtonTapped(_ sender: UIButton) {
        if likeButton.isSelected == true {
          likeButton.isSelected = false
           //isLiked = false
        } else {
          likeButton.isSelected = true
           //isLiked = true
        }
    }
}

