//
//  SecondViewController.swift
//  StreetCat
//
//  Created by 김아연 on 17/11/2019.
//  Copyright © 2019 songji. All rights reserved.
//

import Foundation
import UIKit
class SecondViewController: UIViewController{
    
    @IBAction func Back(_ sender: Any) {

        self.presentingViewController?.dismiss(animated: true)
    }
}
