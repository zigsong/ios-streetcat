//
//  ViewController.swift
//  StreetCat
//
//  Created by songji on 08/11/2019.
//  Copyright © 2019 songji. All rights reserved.


import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    enum DecodingError: Error {
        case missingFile
    }
    
    var cats: [CatAnnotation] = []
    
    // 정보 페이지에 그냥 연결한 샘플 나중에 지워도 됨.
    var catName = "CAT"
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    //    let catAnnotations = CatAnnotations()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.delegate = self
//        mapView.showsUserLocation = true // 현재위치를 마커로 표시 // CL과 함께 사용
        
        //        setAnnotation(latitudeValue: 37.4812114, longitudeValue: 126.9527522, delta: 0.01, title: "설입냥", subtitble: "고양이설명텍스트")
                
        //        let cat = Cat(title: "설입냥",
        //          locationName: "서울대입구",
        //          discipline: "삼색냥이",
        //          coordinate: CLLocationCoordinate2D(latitude: 37.4812114, longitude: 126.9527522))
        //        myMap.addAnnotation(cat)
        //        myMap.addAnnotations(catAnnotations.cats)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D {
            let pLocation = CLLocationCoordinate2DMake(latitudeValue,longitudeValue)
    //        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
    //        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
           // myMap.setRegion(pRegion, animated: true)
            return pLocation
        }
    
    //    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double, title strTitle: String, subtitble strSubtitle:String) {
    //        let annotation = MKPointAnnotation()
    //        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
    //        annotation.title = strTitle
    //        annotation.subtitle = strSubtitle
    //        myMap.addAnnotation(annotation)
    //    }

    // 혜민 님 코드에 없던데 혹시 몰라서 주석 처리했어요.
//    func myLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D {
//        let coordinateLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
//        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
//        // 기존 함수: MKCoordinateSpanMake(delta, delta)
//        let locationRegion = MKCoordinateRegion(center: coordinateLocation, span: spanValue)
//        // 기존함수: MKCoordinateRegionMake(coordinateLocation, spanValue)
//        mapView.setRegion(locationRegion, animated: true)
//        return coordinateLocation
//    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue:  (pLocation?.coordinate.longitude)!, delta: 0.01)
    }
    
    //MARK: - 지은 님 코드
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
               mapView.addAnnotations(cats)
           } catch {
             print(error)
         }
     }
     
     
//    let cat1 = CatAnnotation(title: "test", color: "yellow", spot: CLLocationCoordinate2D(latitude: 37.51, longitude: 126.96), coordinate: CLLocationCoordinate2D(latitude: 37.51, longitude: 126.96))
    
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

extension ViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard let annotation = annotation as? CatAnnotation else { return nil }
    var identifier = "marker"
    var color = UIColor.red
//    switch annotation.color {
//        case "black" :
//            identifier = "Black"
//            color = .black
//        case "white" :
//            identifier = "White"
//            color = .white
//        case "orange" :
//            identifier = "Orange"
//            color = .orange
//        }
    if annotation.color == "black" { identifier = "Black"
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
    
//    private func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//
//        if control == view.rightCalloutAccessoryView {
//            self.performSegue(withIdentifier: "GoDetail", sender: self)
//        }
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if segue.identifier == "GoDetail" {
//        _ = segue.destination as! DetailViewController
//        destinationVC.catName = catName
//    }
//        else if segue.identifier == "goToAdd" {
//        let destinationVC = segue.destination as! AddViewController
//    }
}
    
