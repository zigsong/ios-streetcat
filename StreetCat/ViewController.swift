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

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
        
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
    
    let picker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func addAction(_ sender: Any) {
        let alert =  UIAlertController(title: "타이틀", message: "메세지", preferredStyle: .actionSheet)
        
        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary()
        }
        
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func openLibrary(){
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    
    func openCamera(){
        picker.sourceType = .camera
        present(picker, animated: false, completion: nil)
    }
    
}


extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            imageView.image = image
            print(info)
                
        }
        dismiss(animated: true, completion: nil)
    }
}
