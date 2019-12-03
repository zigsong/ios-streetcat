//
//  infoViewController.swift
//  StreetCats
//
//  Created by ihyemin on 02/12/2019.
//  Copyright © 2019 ihyemin. All rights reserved.


import UIKit


class infoViewController: UIViewController { // 지은) 준현님 코드 추가 테스트(for git sourcetree)
    var catName: String?
       
       @IBOutlet weak var catNameLabel: UILabel!
       @IBOutlet weak var catImage: UIImageView!
       
       
       override func viewDidLoad() {
           super.viewDidLoad()
           // DB에서 클릭된 고양이의 정보(이름, 장소, 이미지, 상세 정보)를 불러와서 보여줍니다.
           
           catNameLabel.text = catName
           catImage.image = #imageLiteral(resourceName: "cat1")
       }
       
       @IBAction func returnToMap(_ sender: UIButton) {
           self.dismiss(animated: true, completion: nil)
        }
}
