//
//  InfoViewController.swift
//  StreetCat
//
//  Created by Claire Hyejee Roh on 2019/11/16.
//  Copyright © 2019 songji. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    var catName: String?
    
    @IBOutlet weak var catNameLabel: UILabel!
    @IBOutlet weak var catImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // DB에서 클릭된 고양이의 정보(이름, 장소, 이미지, 상세 정보)를 불러와서 보여줍니다.
        
        catNameLabel.text = catName
        catImage.image = #imageLiteral(resourceName: "cat1")
    }
    
    // 수정하기 버튼도 추가하는 게 좋을 지는 모르겠네요. 사람마다 입력하고 싶어하는 정보가 다 다를 것 같아서 가장 먼저 등록한 사람이 그 고양이의 주인이 되는 느낌으로.. 하면 될까 싶습니다.
    
    @IBAction func returnToMap(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
