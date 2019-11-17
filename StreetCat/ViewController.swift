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

    func myLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D {
        let coordinateLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        // 기존 함수: MKCoordinateSpanMake(delta, delta)
        let locationRegion = MKCoordinateRegion(center: coordinateLocation, span: spanValue)
        // 기존함수: MKCoordinateRegionMake(coordinateLocation, spanValue)
        mapView.setRegion(locationRegion, animated: true)
        return coordinateLocation
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last
        _ = myLocation(latitude: (lastLocation?.coordinate.latitude)!, longitude: (lastLocation?.coordinate.longitude)!, delta: 0.01)
        // delta값이 1보다 작을수록 확대됨. 100배 확대
    }
    
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double, title strTitle: String, subtitble strSubtitle:String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = myLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        myMap.addAnnotation(annotation)
    }
    
    @IBAction func sgChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            locationManager.startUpdatingLocation()
        } else if sender.selectedSegmentIndex == 1 {
            setAnnotation(latitudeValue: 37.4812114, longitudeValue: 126.9527522, delta: 0.01, title: "설입냥", subtitble: "고양이설명텍스트")
        }
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
   
}
