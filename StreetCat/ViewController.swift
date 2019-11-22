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
    let catAnnotations = CatAnnotations()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self // locatonManager가 현재 mapView에서 delegate처리를 할 수 있도록
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 위치 정확도 최고
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        self.mapView.delegate = self;
        self.mapView.showsUserLocation = true // 현재위치를 마커로 표시 // CL과 함께 사용
        
//        mapView.setRegion(initialregion, animated: true)
//        // add the annotations
        mapView.addAnnotations(catAnnotations.cats)
        
//        let test_01 = MKPointAnnotation()
//        test_01.title = "Test"
//        test_01.coordinate = CLLocationCoordinate2D(latitude: 37.523755, longitude: 126.891938)
//        mapView.addAnnotation(test_01)
    }
    
    //    override func didReceiveMemoryWarning() {
    //        super.didReceiveMemoryWarning()
    //    }
    
    func myLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D {
        let coordinateLocation = CLLocationCoordinate2DMake(latitude, longitude)
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
    
    func setLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D {
        let coordinateLocation = CLLocationCoordinate2DMake(latitude, longitude)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        // 기존 함수: MKCoordinateSpanMake(delta, delta)
        let locationRegion = MKCoordinateRegion(center: coordinateLocation, span: spanValue)
        // 기존함수: MKCoordinateRegionMake(coordinateLocation, spanValue)
        mapView.setRegion(locationRegion, animated: true)
        return coordinateLocation
    }
    
//    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double, title strTitle: String, subtitble strSubtitle:String) {
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = myLocation(latitude: latitudeValue, longitude: longitudeValue, delta: span)
//        annotation.title = strTitle
//        annotation.subtitle = strSubtitle
//    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = MKMarkerAnnotationView()
        guard let annotation = annotation as? CatAnnotation else {return nil}
        var identifier = ""
        var color = UIColor.red
        switch annotation.catColor {
            case .black:
                identifier = "Black"
                color = .black
            case .white:
                identifier = "White"
                color = .white
            case .orange:
                identifier = "Orange"
                color = .orange
            }
            if let dequedView = mapView.dequeueReusableAnnotationView(
                withIdentifier: identifier)
                as? MKMarkerAnnotationView {
                annotationView = dequedView
            } else{
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            }
            annotationView.markerTintColor = color
            annotationView.glyphImage = UIImage(named: "WhiteCat")
//            annotationView.glyphTintColor = .yellow
            annotationView.clusteringIdentifier = identifier
            return annotationView
    }
    
    
        
//        let identifier = "Annotation"
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//
//        if annotationView == nil {
//            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            annotationView!.canShowCallout = true
//        } else {
//            annotationView!.annotation = annotation
//        }
//
//        return annotationView
//    }
    // CatMarkerTest.swift 에서 설정한 Marker Array를 지도에 표시하기
    
    
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
