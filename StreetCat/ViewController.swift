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
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    // self.mapview.delegate = self

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self // locatonManager가 현재 mapView에서 delegate처리할 수 있도록 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 위치 정확도 최고
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.delegate = self
        mapView.showsUserLocation = true // 현재위치를 마커로 표시(실제로 표시하지는 않음) // CL과 함께 사용
        // print(self.mapView.isUserLocationVisible)
    }
    
    func myLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D {
        let coordinateLocation = CLLocationCoordinate2DMake(latitude, longitude)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let locationRegion = MKCoordinateRegion(center: coordinateLocation, span: spanValue)
        mapView.setRegion(locationRegion, animated: true)
        return coordinateLocation
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last
        _ = myLocation(latitude: (lastLocation?.coordinate.latitude)!, longitude: (lastLocation?.coordinate.longitude)!, delta: 0.01)
        // delta값이 1보다 작을수록 확대됨. 100배 확대
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
}
