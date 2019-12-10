//
//  ViewController.swift
//  StreetCats
//
//  Created by ihyemin on 02/12/2019.
//  Copyright © 2019 ihyemin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    enum DecodingError: Error {
        case missingFile
    }
    
    var cats: [CatAnnotation] = []
    
    @IBOutlet weak var myMap: MKMapView!
    let locationManager = CLLocationManager()
    //    let catAnnotations = CatAnnotations()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy=kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        myMap.showsUserLocation = true
        myMap.delegate = self
//        setAnnotation(latitudeValue: 37.4812114, longitudeValue: 126.9527522, delta: 0.01, title: "설입냥", subtitble: "고양이설명텍스트")
//        DataManager.shared.mainVC = self // singleton 추가 (data input 이후 reload 용도)
        makeMockData()
    }
    
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue,longitudeValue)
        //        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        //        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        // myMap.setRegion(pRegion, animated: true)
        return pLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue:  (pLocation?.coordinate.longitude)!, delta: 0.01)
    }
    
    func loadMockData() throws -> CatList {
        guard let url = Bundle.main.url(forResource: "cats", withExtension: "json") else {
            throw DecodingError.missingFile
        }
        
        let decoder = JSONDecoder()
        let data = try Data(contentsOf: url)
        return try decoder.decode(CatList.self, from: data)
    }
    
    func makeMockData() {
//        if ( "savedCats.json" 이 있다면) {
//            "savedCats.json"을 디코딩한 목록을 보여주고
//        }
//        else {
            do {
                let catList = try loadMockData()
                // print(catList)
                cats = []
                for cat in catList.cats { // Catprofile의 CatList 수정 후 optional unwrapping 생김
                    // print("\(cat.name)")
                    
                    cats += [CatAnnotation(title: cat.name, color: cat.color, spot: CLLocationCoordinate2D(latitude: cat.spot.coordinate.latitude, longitude: cat.spot.coordinate.longitude), coordinate: CLLocationCoordinate2D(latitude: cat.spot.coordinate.latitude, longitude: cat.spot.coordinate.longitude), details: cat.details, isLiked: cat.isLiked)]
                }
                myMap.addAnnotations(cats)
            } catch {
                print(error)
            }
//        }
    }
    
    @IBAction func AddNewCat(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToAdd", sender: self)
    }
    
    @IBAction func CheckCatInfo(_ sender: UIButton) {
        // 핀의 label에 있는 고양이의 이름을 받아서 넘기는 코드 필요.
        
        self.performSegue(withIdentifier: "goToInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToInfo" {
            let destinationVC = segue.destination as! DetailViewController
        
        } else if segue.identifier == "goToAdd" {
            let destinationVC = segue.destination as! AddViewController
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? CatAnnotation else { return nil }
        var identifier = "marker"
        var color = UIColor.red

        if annotation.color == "black" { identifier = "Black" // json color string의 값이 black이면,
            color = .black}
        else if annotation.color == "white" { identifier = "White"
            color = .white}
        else if annotation.color == "orange" { identifier = "Orange"
            color = .orange}
        else {identifier = "else"
            color = .red }
        
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        view.markerTintColor = color
        //                view.glyphImage = UIImage(named: "WhiteCat")
        //            annotationView.glyphTintColor = .yellow
        view.clusteringIdentifier = identifier
        return view
    }
    
    // AddVC로 갔다가 되돌아왔을 떄 실행 (AddVC가 dismiss되면 자동으로 viewWillAppear가 실행됨)
    override func viewWillAppear(_ animated: Bool){
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

            let file = "savedCats.json"
            let fileURL = dir.appendingPathComponent(file)

            // reading & decoding & addAnnotation
            do {
                let newCatData = try String(contentsOf: fileURL, encoding: .utf8)
                // print(newCatData) // 정상작동(json String으로 출력) - AddVC의 추가하기가 내려가면 자동으로 출력됨. 왜 print("viewWillAppear")는 안될까?
                let decoder = JSONDecoder()
                let data = Data(newCatData.utf8)
                let newCat = try decoder.decode(Cat.self, from: data)
                print(newCat) // test

                let newCatMark = CatAnnotation(title: newCat.name, color: newCat.color, spot: CLLocationCoordinate2D(latitude: newCat.spot.coordinate.latitude, longitude: newCat.spot.coordinate.longitude), coordinate: CLLocationCoordinate2D(latitude: newCat.spot.coordinate.latitude, longitude: newCat.spot.coordinate.longitude), details: newCat.details, isLiked: false)
                
                myMap.addAnnotation(newCatMark)
            }
            catch {
                print("error: \(error)") // keyNotFound error 발생
            }
        }
        
        print("viewWillAppear")
    }

}

//AddVC가 dismiss된 후 data reload 위해 싱글톤 객체 생성
//class DataManager {
//    static let shared = DataManager()
//    var mainVC = ViewController()
//}


