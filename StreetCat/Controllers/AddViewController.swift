//
//  AddViewController.swift
//  StreetCat
//
//  Created by Claire Hyejee Roh on 2019/11/16.
//  Copyright © 2019 songji. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    let picker = UIImagePickerController()
    
    @IBOutlet weak var addImage: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var warningSign: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        nameTextField.delegate = self
        infoTextView.delegate = self
        
        // 사진 추가 버튼의 프레임 설정
        self.addImage.layer.borderWidth = 0.5
        self.addImage.layer.borderColor = UIColor.lightGray.cgColor

        // 상세 정보 칸의 프레임 설정
        self.infoTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.infoTextView.layer.borderWidth = 1
        self.infoTextView.layer.cornerRadius = 10
        
        // textview의 placeholder 역할
        self.infoTextView.text = "내용을 입력하세요."
        self.infoTextView.textColor = UIColor.lightGray
        
        self.warningSign.text = ""
        self.warningSign.textColor = UIColor.red
    }
    
    
    @IBAction func addImage(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: "고양이 사진을 등록합니다.", preferredStyle: .actionSheet)
        let library = UIAlertAction(title: "사진 앨범", style: .default) { (action) in self.openLibrary()
        }
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in self.openCamera()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    // 이름 입력 후 '확인' 버튼을 누르면 나타날 액션
    @IBAction func nameButtonPressed(_ sender: UIButton) {
        nameTextField.endEditing(true)
        // action
    }
    
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        infoTextView.endEditing(true)
    }
    
    @IBAction func finalConfirm(_ sender: UIButton) {
        
        if nameTextField.text != "" {
        
            // 이 경우에 입력된 이름, 장소, 이미지, 상세 정보를 모두 받아서 DB로 넘기고 저장이 필요함.
            
            self.dismiss(animated: true, completion: nil)
        } else {
            warningSign.text = "입력이 모두 완료되지 않았습니다."
        }
    }
    
    
    @IBAction func finalCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}


//MARK: - 고양이 사진을 추가하기 위해서 필요한 Image Picker 관련 extension

extension AddViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openLibrary(){
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    
    func openCamera(){
        if (UIImagePickerController .isSourceTypeAvailable(.camera)) {
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
        } else {
            print("Camera not available")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            print(info)
        }
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - 이름 입력을 위해 필요한 Text Field의 프로토콜을 받는 extension

extension AddViewController : UITextFieldDelegate {
    
    // 자판의 return or enter 버튼을 눌렀을 경우 나타날 액션
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.endEditing(true)
        // action
        return true
    }
    
    // 입력 완료할지 말지 결정하는 것 같아요. 아래는 사용자가 입력을 안하고 넘어가려고 할 경우에 입력이 필요하다고 메시지를 주고, 입력 완료로 넘어가지 못하게 하는 구문입니다.
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if nameTextField.text != "" {
            return true
        } else {
            nameTextField.attributedPlaceholder = NSAttributedString(string: "입력이 필요합니다.",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            return true
        }
    }
    
    // 입력이 완료되었을 경우 나타날 액션인데, 텍스트 입력창이 여러 개인 경우에는 어떻게 될 지를 모르겠네요..
    func textFieldDidEndEditing(_ textField: UITextField) {
        // 입력 다 하고 나서 취해질 액션
        
    }
}

//MARK: - 상세 정보를 입력할 때 필요한 Text View의 extension

extension AddViewController : UITextViewDelegate {
    
    // 정보 입력 시작할 경우
    func textViewDidBeginEditing(_ textView: UITextView) {
        textViewSetupView()
    }
    
    // 정보 입력 마칠 경우
    func textViewDidEndEditing(_ textView: UITextView) {
        if infoTextView.text == "" {
            textViewSetupView()
        }
    }
    
    // 정보 입력될 때
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            infoTextView.resignFirstResponder()
        }
        return true
    }
    
    func textViewSetupView() {
        if infoTextView.text == "내용을 입력하세요." {
            infoTextView.text = ""
            infoTextView.textColor = UIColor.black
        } else if infoTextView.text == "" {
            infoTextView.text = "내용을 입력하세요."
            infoTextView.textColor = UIColor.lightGray
        }
    }
}
