//
//  DetailViewController.swift
//  StreetCats
//
//  Created by ihyemin on 02/12/2019.
//  Copyright © 2019 ihyemin. All rights reserved.


import UIKit
import MapKit

<<<<<<< HEAD
class DetailViewController: UIViewController {
    
//    var catName: String?
        
=======
class DetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
            
>>>>>>> eb502853b23cfdd7933f574ac9b642b8f3d7f901
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
<<<<<<< HEAD
        
    override func viewDidLoad() {
        super.viewDidLoad()

            catNameLabel.text = cats[indexOfCat].title
            catDetailLabel.text = cats[indexOfCat].details
            likeButton.isSelected = cats[indexOfCat].isLiked
            catImage.image = cats[indexOfCat].photo

    }
=======
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        catNameLabel.text = (nameTextField.text != "") ? nameTextField.text : cats[indexOfCat].title
        catDetailLabel.text = (detailTextView.text != "") ? detailTextView.text : cats[indexOfCat].details
        likeButton.isSelected = cats[indexOfCat].isLiked
        catImage.image = cats[indexOfCat].photo
        
        nameTextField.delegate = self
        nameTextField.isHidden = true
        catNameLabel.isUserInteractionEnabled = true
        detailTextView.delegate = self
        detailTextView.isHidden = true
        catDetailLabel.isUserInteractionEnabled = true
        
        let nameTapGesture = UITapGestureRecognizer(target: self, action: #selector(nameLabelTapped))
        let detailTapGesture = UITapGestureRecognizer(target: self, action: #selector(detailLabelTapped))
        nameTapGesture.numberOfTapsRequired = 1
        detailTapGesture.numberOfTouchesRequired = 1
        catNameLabel.addGestureRecognizer(nameTapGesture)
        catDetailLabel.addGestureRecognizer(detailTapGesture)

    }
    
    @objc func nameLabelTapped(){
        catNameLabel.isHidden = true
        nameTextField.isHidden = false
        nameTextField.text = catNameLabel.text
    }
    
    @objc func detailLabelTapped(){
        catDetailLabel.isHidden = true
        detailTextView.isHidden = false
        detailTextView.text = catDetailLabel.text
        print("detail tapped")
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
        nameTextField.endEditing(true)
        nameTextField.isHidden = true
        catNameLabel.isHidden = false
        catNameLabel.text = nameTextField.text
        cats[indexOfCat].title = nameTextField.text
        return true
    }
    
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
//        textField.resignFirstResponder()
        detailTextView.endEditing(true)
        detailTextView.isHidden = true
        catDetailLabel.isHidden = false
        catDetailLabel.text = detailTextView.text
        cats[indexOfCat].details = detailTextView.text
        return true
    }
>>>>>>> eb502853b23cfdd7933f574ac9b642b8f3d7f901

    func convertBase64ToImage(_ str: String) -> UIImage {
        let dataDecoded : Data = Data(base64Encoded: str, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        return decodedimage!
    }


    @IBAction func returnToMap(_ sender: UIButton) {
<<<<<<< HEAD
        
=======
>>>>>>> eb502853b23cfdd7933f574ac9b642b8f3d7f901
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
