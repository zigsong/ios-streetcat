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
    
    enum DecodingError: Error {
        case missingFile
    }
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    // self.mapview.delegate = self

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self // locatonManager가 현재 mapView에서 delegate처리할 수 있도록 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 위치 정확도 최고
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        self.mapView.delegate = self;
        self.mapView.showsUserLocation = true // 현재위치를 마커로 표시(실제로 표시하지는 않음???) // CL과 함께 사용
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
    
    func loadMockData() throws -> CatList {
        guard let url = Bundle.main.url(forResource: "cats", withExtension: "json") else {
            throw DecodingError.missingFile
        }
        
        let decoder = JSONDecoder()
        let data = try Data(contentsOf: url)
        return try decoder.decode(CatList.self, from: data)
    }
    
    @IBAction func makeMockData(_ sender: UIButton) {
        do {
            let catList = try loadMockData()
            
            for cat in catList.cats {
                print("\(cat.name)")
            }
        } catch {
            print(error)
        }
        
        
// *** 지도 작업 할 것 *** //
        // let marker = MKMarkerAnnotationView()
//        func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double, title strTitle: String, subtitble strSubtitle:String) {
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = myLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
//            annotation.title = strTitle
//            annotation.subtitle = strSubtitle
//            myMap.addAnnotation(annotation)
//        }
        
    }
}

