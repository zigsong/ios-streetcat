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
        
        //        let cat = Cat(title: "설입냥",
        //          locationName: "서울대입구",
        //          discipline: "삼색냥이",
        //          coordinate: CLLocationCoordinate2D(latitude: 37.4812114, longitude: 126.9527522))
        //        myMap.addAnnotation(cat)
        //        myMap.addAnnotations(catAnnotations.cats)
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
    
    @IBAction func makeMockData(_ sender: UIButton) {
        do {
            let catList = try loadMockData()
            // print(catList)
            cats = []
            for cat in catList.cats {
                print("\(cat.name)")
                
                cats += [CatAnnotation(title: cat.name, color: cat.color, spot: CLLocationCoordinate2D(latitude: cat.spot.coordinate.latitude, longitude: cat.spot.coordinate.longitude), coordinate: CLLocationCoordinate2D(latitude: cat.spot.coordinate.latitude, longitude: cat.spot.coordinate.longitude))]
            }
            myMap.addAnnotations(cats)
        } catch {
            print(error)
        }
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
            let destinationVC = segue.destination as! InfoViewController
        
        } else if segue.identifier == "goToAdd" {
            let destinationVC = segue.destination as! AddViewController
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
<<<<<<< HEAD
    view.markerTintColor = color
                view.glyphImage = UIImage(named: "CatFace")
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
=======
>>>>>>> c72b6df54e7ceebb204b7fd4b2807d0b86748fde
    
    
}

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
        view.glyphImage = UIImage(named: "CatFace")
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


