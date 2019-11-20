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
    
    @IBAction func makeMockData(_ sender: UIButton) {
  
        struct Cat: Codable {
            // typealias CLLocationDegrees = Double
            var name: String
            var character: String
            // var photo: UIImage
            var spot: Double
        }

        enum DecodingError: Error {
            case missingFile
        }
        
// *** 구글링 1 https://stackoverflow.com/questions/54089660/how-to-parse-json-data-from-local-files
//        let url = Bundle.main.url(forResource: "cats", withExtension: "json")!
//        let data = try! Data(contentsOf: url)
//        let JSON = try! JSONSerialization.jsonObject(with: data, options: [])
//        // print(".........." , JSON , ".......")
//        if let cats = JSON as? [[String: Any]] {
//            for cat in cats {
//                let name = cat["name"] as? String ?? "No Name"
//                let character = cat["character"] as? String ?? "No Character"
//                // let spot = cat["spot"] as? Double ?? "No Spot"
//                print("=======",name, character, "=======")
//            }
//        }
        
// *** 구글링 2 https://stackoverflow.com/questions/50945202/how-to-get-data-from-local-json-file-in-swift *** //
//        let url = Bundle.main.url(forResource: "cats", withExtension: "json")!
//        do {
//            let jsonData = try Data(contentsOf: url)
//            let json = try JSONSerialization.jsonObject(with: jsonData) as! [[String: Any]]
//
//            if let cat1 = json.first {
//                print( cat1["name"] as Any)
//            }
//        }
//        catch {
//            print(error)
//        }
        
// *** 교수님의 자료 *** //.
//        let cat1 = Cat(name: "zig", character: "dizzy", spot: 33)
//        print(cat1.name)
        
//        guard let url = Bundle.main.url(forResource: "cats", withExtension: "json") else {
//            throw DecodingError.missingFile // 위에서 DecodingError를 명시
//            }
//        let decoder = JSONDecoder()
//        let data = try Data(contentsOf: url)
//        cat = try decoder.decode(Cat.self, from: data) // QQ. [Cat].self라고 해야 하는지?
        
        // print(cat)
        
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

