//
//  AddViewController.swift
//  StreetCat
//
//  Created by Claire Hyejee Roh on 2019/11/16.
//  Copyright © 2019 songji. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {
    
    let picker = UIImagePickerController()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        picker.delegate = self
    }
    
    
    // 이름 입력 후 '입력' 버튼을 누르면 나타날 액션
    @IBAction func nameButtonPressed(_ sender: UIButton) {
        nameTextField.endEditing(true)
        // action
    }
    
    
    @IBAction func addImage(_ sender: UIButton) {
        let alert = UIAlertController(title: "원하는 타이틀", message: "원하는 메시지", preferredStyle: .actionSheet)
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
    
    
    @IBAction func finalConfirm(_ sender: UIButton) {
    }
    
    
    @IBAction func finalCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // 자판의 return or enter 버튼을 눌렀을 경우 나타날 액션
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.endEditing(true)
        // action
        return true
    }
    
    // 입력 완료할지 말지 결정하는 것 같아요. 아래는 사용자가 입력을 안하고 넘어가려고 할 경우에 입력이 필요하다고 메시지를 주고, 입력 완료로 넘어가지 못하게 하는 구문입니다. 어느 텍스트창이든 빈 칸으로 넘어가지 못하게 하려면 if 문 안의 nameTextField를 그냥 textField로 바꿔도 됩니다.
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if nameTextField.text != "" {
            return true
        } else {
            nameTextField.placeholder = "입력이 필요합니다."
            return false
        }
    }
    
    // 입력이 완료되었을 경우 나타날 액션인데, 텍스트 입력창이 여러 개인 경우에는 어떻게 될 지를 모르겠네요.. 전체 완료 후 나타날 반응인 것 같아요
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        // 일반적으로 search를 하고 나서 그 칸을 clear할 때 씁니다.
        
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


//MARK: - 고양이 사진을 추가하기 위해서 필요한 extension

extension AddViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
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
