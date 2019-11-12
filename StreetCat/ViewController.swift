//
//  ViewController.swift
//  StreetCat
//
//  Created by songji on 08/11/2019.
//  Copyright © 2019 songji. All rights reserved.


import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self // locatonManager가 현재 mapView에서 delegate처리할 수 있도록 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 위치 정확도 최고
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.delegate = self;
        mapView.showsUserLocation = true // 현재위치를 마커로 표시(실제로 표시하지는 않음???) // CL과 함께 사용
        // print(self.mapView.isUserLocationVisible)

//        func configureLocationServices() {
//            locationManager.delegate = self
//            let status = CLLocationManager.authorizationStatus()
//            if status == .notDetermined {
//                locationManager.requestWhenInUseAuthorization()
//            } else if status == .authorizedAlways || status == .authorizedWhenInUse {
//                beginLocationsUpdate(locationManager: locationManager)
//            }
//            print(status)
//        }
//
//        func beginLocationsUpdate(locationManager: CLLocationManager) {
//            // turn on setting to show location if authorized
//            mapView.showsUserLocation = true
//            // accuracy of location data can choose precision
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.startUpdatingLocation()
//        }
//
//        configureLocationServices()
    }
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }

    func myLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, delta: Double) {
        let coordinateLocation = CLLocationCoordinate2DMake(latitude, longitude)
        let spanValue = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        // 기존 함수: MKCoordinateSpanMake(delta, delta)
        let locationRegion = MKCoordinateRegion(center: coordinateLocation, span: spanValue)
        mapView.setRegion(locationRegion, animated: true)
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
   
}
