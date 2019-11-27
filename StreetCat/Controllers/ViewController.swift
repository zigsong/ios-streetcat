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
    
    var cats: [CatAnnotation] = []
    
    var catName = "CAT"
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.delegate = self
        mapView.showsUserLocation = true // 현재위치를 마커로 표시 // CL과 함께 사용
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
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
        _ = myLocation(latitudeValue: (lastLocation?.coordinate.latitude)!, longitudeValue: (lastLocation?.coordinate.longitude)!, delta: 0.01)
        // delta값이 1보다 작을수록 확대됨. 100배 확대
    }

    
    //MARK: - 이하 노준현 전까지 지은 님 코드
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
                // print(catList)
               cats = []
               for cat in catList.cats {
                   print("\(cat.name)")
                
                cats += [CatAnnotation(title: cat.name, color: cat.color, spot: CLLocationCoordinate2D(latitude: cat.spot.coordinate.latitude, longitude: cat.spot.coordinate.longitude), coordinate: CLLocationCoordinate2D(latitude: cat.spot.coordinate.latitude, longitude: cat.spot.coordinate.longitude))]
               }
               mapView.addAnnotation(cat1)
               mapView.addAnnotations(cats)
           } catch {
               print(error)
           }
    }
    
    let cat1 = CatAnnotation(title: "test", color: "yellow", spot: CLLocationCoordinate2D(latitude: 37.51, longitude: 126.96), coordinate: CLLocationCoordinate2D(latitude: 37.51, longitude: 126.96))
    
     // marker 클릭 시 info page를 보여주기 위한 코드
     func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

       guard let annotation = annotation as? CatAnnotation else { return nil }
       let identifier = "marker"
       var view: MKMarkerAnnotationView
       if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
         as? MKMarkerAnnotationView {
         dequeuedView.annotation = annotation
         view = dequeuedView
       } else {
         view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
         view.canShowCallout = true // annotaion이 추가 info를 보여줄 수 있느닞?
         view.calloutOffset = CGPoint(x: -5, y: 5) // callout의 위치(2차원 좌표)
         view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) // callout의 우측에 info 버튼을 추가
       }
       return view
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
    
    //MARK: - 이하 노준현 코드
    @IBAction func AddNewCat(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToAdd", sender: self)
    }
    
    @IBAction func CheckCatInfo(_ sender: UIButton) {
        // 핀의 label에 있는 고양이의 이름을 받아서 넘기는 코드 필요.
        
        self.performSegue(withIdentifier: "goToInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToInfo" {
            let destinationVC = segue.destination as! InfoViewController
            destinationVC.catName = catName
        } else if segue.identifier == "goToAdd" {
            let destinationVC = segue.destination as! AddViewController
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
//
//class CustomAnnotationView: MKPinAnnotationView {  // or nowadays, you might use MKMarkerAnnotationView
//    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
//        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
//
//        canShowCallout = true
//        rightCalloutAccessoryView = UIButton(type: .infoLight)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//}
