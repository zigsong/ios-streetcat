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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        catNameLabel.text = catName
    }
    
    @IBAction func returnToMap(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
