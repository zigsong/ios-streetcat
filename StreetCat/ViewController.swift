//
//  ViewController.swift
//  StreetCat
//
//  Created by songji on 08/11/2019.
//  Copyright © 2019 songji. All rights reserved.
//

//import MapKit
//
//class ViewController: UIViewController {
//    @IBOutlet weak var mapView: MKMapView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    let location = CLLocationCoordinate2D(latitude: 51.50007773, longitude: -0.1246402)
//
//    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//
//    let region = MKCoordinateRegion(center: location, span: span)
//        mapView.setRegion(region, animated: true)
//
//    let annotation = MKPointAnnotation()
//       annotation.coordinate = location
//       annotation.title = "Big Ben"
//       annotation.subtitle = "London"
//       mapView.addAnnotation(annotation)
//
//    }
//}


import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,  MKMapViewDelegate, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self // locatonManager가 현재 mapView에서 delegate처리를 할 수 있도록
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 위치 정확도 최고
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        self.mapView.delegate = self;
        self.mapView.showsUserLocation = true // 현재위치를 마커로 표시 // CL과 함께 사용
    }
        
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }

    func myLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, delta: Double) {
        let coordinateLocation = CLLocationCoordinate2DMake(latitude, longitude)
        let spanValue = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        // 기존 함수: MKCoordinateSpanMake(delta, delta)
        let locationRegion = MKCoordinateRegion(center: coordinateLocation, span: spanValue)
        // 기존함수: MKCoordinateRegionMake(coordinateLocation, spanValue)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last
        myLocation(latitude: (lastLocation?.coordinate.latitude)!, longitude: (lastLocation?.coordinate.longitude)!, delta: 0.01)
        // delta값이 1보다 작을수록 확대됨. 100배 확대
    }
    

//        self.locationManager.requestWhenInUseAuthorization() // .requestAlwaysAuthorization()
//        var currentLoc: CLLocation!
//        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
//        CLLocationManager.authorizationStatus() == .authorizedAlways) {
            // 인증 상태가 유효하다면(위치 항상 허용/ 앱을 사용하는 동안)
//        if CLLocationManager.locationServicesEnabled() {
//            currentLoc = locationManager.location
//            print(currentLoc.coordinate.latitude)
//            print(currentLoc.coordinate.longitude)
//        } else {
//            print("error")
//        }
   
    
//ahyeon
    
    @IBAction func alert(_ sender: Any) {
         let alert = UIAlertController(title: "고양이 이름", message: nil, preferredStyle: .alert)
                //알림 뜨는 것
                let cancel = UIAlertAction(title: "취소", style: .cancel)
                
                let next = UIAlertAction(title: "상세정보 보기", style: .default) { (_) in
                    guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") else {
                        return
                    }
                    //뷰 컨트롤러를 참조
                    uvc.modalTransitionStyle = UIModalTransitionStyle.partialCurl
                    //애니메이션 지정
                    self.present(uvc, animated: true)
                }
                //메시지창 객체 생성
                alert.addAction(cancel)
                alert.addAction(next)
                //버튼을 컨트롤러에 등록
                let contentVC = ImageViewController()
                //컨텐트 뷰 영역 안에 들어갈 컨트롤러 생성
                alert.setValue(contentVC, forKeyPath: "contentViewController")
                //알림창의 컨텐츠 뷰 컨트롤러 속성에 등록
                self.present(alert, animated:false)
                //메시지창 실행
            }
            //고양이 추가하고 싶을 때 _ 이미지 추가는 다른 파일에 있고 이건 텍스트 추가
           
    @IBOutlet var imgView: UIImageView!
    @IBAction func 추가(_ sender: Any) {
        //이미지 피커 컨트롤러 인스턴스 생성
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            //이미지 소스로 사진첩 선택
            picker.allowsEditing = true
            //사진 짜르거나 할 수 있게 편집기능
            picker.delegate = self
            //델리게이트 지정 ..?
            self.present(picker, animated: false)
            //이미지 피커 컨트롤러 실행
            
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.dismiss(animated: false)
        } //이미지 선택하지 않고 취소했을 때
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: false) { () in
                let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
                self.imgView.image = img
            } //이미지를 이미지 뷰에 표시
            
        }
}

        // 알림창에 고양이 사진 뜨게 하기 위해서 image라는 폴더 만들어서
        class ImageViewController : UIViewController {
            override func viewDidLoad() {
                super.viewDidLoad()
                
                
                let icon = UIImage(named: "persian.jpg")
                let iconV = UIImageView(image: icon)
                self.view.addSubview(iconV)
            }
    }


