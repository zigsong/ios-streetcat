//
//  AddViewController.swift
//  StreetCat
//
//  Created by Claire Hyejee Roh on 2019/11/16.
//  Copyright © 2019 songji. All rights reserved.
//

import UIKit
import MapKit // CLLocation에 값을 넣기 위해 필요

class AddViewController: UIViewController {

    var delegate: ViewToViewDelegate?
    var color: String = ""
    // myMap에서 값을 받아오기 위한 롱프레스 변수 설정.
    var longPressedLocation: CLLocationCoordinate2D?
    let picker = UIImagePickerController()
    
    @IBOutlet weak var addImage: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var warningSign: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var whiteButton: UIButton!
    @IBOutlet weak var brownButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var grayButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    
    struct classConstants{
        // 간결한 버전
        // let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("savedCats.json")
        // savedCats.json이 한번만 생성되게끔
        static let fileManager = FileManager.default // filemanager 인스턴스 생성
        static let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0] // path 작성
        static let fileURL = documentsURL.appendingPathComponent("savedCats.json") // savedCats.json 파일 추가
    }
    

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

        // textview의 placeholder 역할 -> 아직 미완성
        self.infoTextView.text = "상세 정보를 입력하세요"
        self.infoTextView.textColor = UIColor.lightGray

        self.warningSign.text = ""
        self.warningSign.textColor = UIColor.lightGray
    }
    
    //좋아요 버튼 관리
    @IBAction func likeButtonTapped() {
        if likeButton.isSelected == true {
           likeButton.isSelected = false
            //isLiked = false
         } else {
           likeButton.isSelected = true
            //isLiked = true
         }
    }
    
//MARK: - 고양이 컬러 선택 버튼들
    
    @IBAction func whiteButtonTapped() {
        if whiteButton.isSelected == false {
            if color != "" {
                color = "white"
                buttonReset()
                whiteButton.isSelected = true
            } else {
                color = "white"
                whiteButton.isSelected = true
            }
        } else {
            color = ""
            buttonReset()
        }
        print(color)
    }
    
    @IBAction func brownButtonTapped() {
        if brownButton.isSelected == false {
            if color != "" {
                color = "brown"
                buttonReset()
                brownButton.isSelected = true
            } else {
                color = "brown"
                brownButton.isSelected = true
            }
        } else {
            color = ""
            buttonReset()
        }
        print(color)
    }
    
    @IBAction func orangeButtonTapped() {
        if orangeButton.isSelected == false {
            if color != "" {
                color = "orange"
                buttonReset()
                orangeButton.isSelected = true
            } else {
                color = "orange"
                orangeButton.isSelected = true
            }
        } else {
            color = ""
            buttonReset()
        }
        print(color)
    }
    
    @IBAction func grayButtonTapped() {
        if grayButton.isSelected == false {
            if color != "" {
                color = "gray"
                buttonReset()
                grayButton.isSelected = true
            } else {
                color = "gray"
                grayButton.isSelected = true
            }
        } else {
            color = ""
            buttonReset()
        }
        print(color)
    }
    
    @IBAction func blackButtonTapped() {
        if blackButton.isSelected == false {
            if color != "" {
                color = "black"
                buttonReset()
                blackButton.isSelected = true
            } else {
                color = "black"
                blackButton.isSelected = true
            }
        } else {
            color = ""
            buttonReset()
        }
        print(color)
    }
    
    func buttonReset() {
        whiteButton.isSelected = false
        brownButton.isSelected = false
        orangeButton.isSelected = false
        grayButton.isSelected = false
        blackButton.isSelected = false
    }

//MARK: - 이미지 추가 버튼
    
    @IBAction func addImage(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: "고양이 사진을 등록합니다", preferredStyle: .actionSheet)
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
    
    func convertImageToBase64(_ image: UIImage) -> String {
        let imageData:NSData = image.jpegData(compressionQuality: 0.4)! as NSData
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        return strBase64
    }
    
    func convertBase64ToImage(_ str: String) -> UIImage {
        let dataDecoded : Data = Data(base64Encoded: str, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        return decodedimage!
    }
    
    // 이름 입력 후 '확인' 버튼을 누르면 나타날 액션
    @IBAction func nameButtonPressed(_ sender: UIButton) { // 추가하기 -> 이름 -> 확인
        nameTextField.endEditing(true)
        // Q. 확인 버튼이 있어야 하나?
        // A. 원래는 리턴만 넣으면 불편할 것 같아서 넣었는데 빼도 될 듯 합니다.
    }
    
    @IBAction func infoButtonPressed(_ sender: UIButton) { // 정보보기
        infoTextView.endEditing(true)
    }

    
//MARK: - 뷰가 사라질 때와 관련된 것들
    
    // 최종 확인을 누르면
    @IBAction func finalConfirm(_ sender: UIButton) {
        // 이름 입력하는 텍스트 필드, 이미지가 필수적으로 채워져야만 함.
        if nameTextField.text != "" {
            // 상세 정보는 필수는 아니지만, 없을 경우 기본값으로 "상세 정보 없음" 메시지가 출력됨.
            if infoTextView.text == "" {
                infoTextView.text = "상세 정보 없음"
            }
            
            // 사용자가 myMap에서 롱프레스하던 위치의 위도, 경도 값을 받아옴.
            let lat = longPressedLocation?.latitude
            let lon = longPressedLocation?.longitude
            
            var cat = Cat(name: nameTextField.text!, color: color, photo: convertImageToBase64(imageView.image!),
                          spot: CLLocation(latitude: lat!, longitude: lon!), details: infoTextView.text, isLiked: false)
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            let jsonData = try! encoder.encode(cat)
            // jsonString으로 제대로 encode되었는지 테스트 출력

            do {
                try jsonData.write(to: classConstants.fileURL)
                print("success") // 정상 작동
                // myMap의 catAdded 함수를 작동시켜서, 디코딩
                delegate?.catAdded()
            } catch {
                print("error")
            }
            self.dismiss(animated: true, completion: nil)

        } else {
            // 이름이나 이미지 중 비어있는 것이 있을 경우 경고 메시지.
            warningSign.textColor = UIColor.red
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
            print(info) // 작동하는 듯
        }
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - 이름 입력을 위해 필요한 Text Field의 프로토콜을 받는 extension

extension AddViewController : UITextFieldDelegate {
    
    // 자판의 return or enter 버튼을 눌렀을 경우 나타날 액션
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 자판 사라짐.
        nameTextField.endEditing(true)
        // action
        return true
    }
    
    // 입력 완료할지 말지 결정하는 것 같아요. 아래는 사용자가 입력을 안하고 넘어가려고 할 경우에 입력이 필요하다고 메시지를 주고, 입력 완료로 넘어가지 못하게 하는 구문입니다.
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if nameTextField.text != "" {
            return true
        } else {
            nameTextField.attributedPlaceholder = NSAttributedString(string: "입력이 필요합니다")
//            attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            return true
        }
    }
    
    // 입력이 완료되었을 경우 나타날 액션?
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
    
    // placeholder 역할 대신함.
    func textViewSetupView() {
        if infoTextView.text == "내용을 입력하세요" {
            infoTextView.text = ""
            infoTextView.textColor = UIColor.label
        } else if infoTextView.text == "" {
            infoTextView.text = "내용을 입력하세요"
            infoTextView.textColor = UIColor.label
        } else if infoTextView.text == "" {
            infoTextView.text = "내용을 입력하세요"
            infoTextView.textColor = UIColor.label
        }
    }
}
