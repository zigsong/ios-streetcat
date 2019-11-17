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
    // self.mapview.delegate = self

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self // locatonManager가 현재 mapView에서 delegate처리할 수 있도록 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 위치 정확도 최고
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.delegate = self;
        mapView.showsUserLocation = true // 현재위치를 마커로 표시(실제로 표시하지는 않음???) // CL과 함께 사용
        // print(self.mapView.isUserLocationVisible)

    func myLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, delta: Double) {
        let coordinateLocation = CLLocationCoordinate2DMake(latitude, longitude)
        let spanValue = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        let locationRegion = MKCoordinateRegion(center: coordinateLocation, span: spanValue)
        mapView.setRegion(locationRegion, animated: true)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last
        myLocation(latitude: (lastLocation?.coordinate.latitude)!, longitude: (lastLocation?.coordinate.longitude)!, delta: 0.01)
        // delta값이 1보다 작을수록 확대됨. 100배 확대
    }
    }
    
    @IBAction func makeMockData(_ sender: UIButton) {
        let cat1 = try! Cat(fileName: "cat")
       
//        let position = CLLocationCoordinate2D(latitude: 10, longitude: 10)
//        let marker = GMSMarker()
//        // let marker = GMSMarker(position: position) 또는 아래 코드
//        // marker.position = CLLocationCoordinate2D(latitude: , longitude: )
//        marker.title = cat1.name
//        marker.map = mapView
        
        // GMSMarker는 GoogleMapkit?
        
        let marker = MKMarkerAnnotationView()
        
    }
}
