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

class ViewController: UIViewController, CLLocationManagerDelegate, ViewToViewDelegate {
    
    enum DecodingError: Error {
        case missingFile
    }
    
    var cats: [CatAnnotation] = []
    var location = "marker"
    // var tapCoordinate = CLLocationCoordinate2D(latitude: 37.5, longitude: 126.5) // assign을 바꿔야 할 듯 
    
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
        makeMockData()
        myMap.isScrollEnabled = true
    }
    
    @IBAction func onTapMapView(gestureRecognizer: UILongPressGestureRecognizer) {
           if gestureRecognizer.state == UIGestureRecognizer.State.began {
               let location = gestureRecognizer.location(in: myMap)
               let tapCoordinate = myMap.convert(location,toCoordinateFrom: myMap)
               
               print("\(tapCoordinate.latitude), \(tapCoordinate.longitude)")
            
//               let annotation = MKPointAnnotation()
//                annotation.coordinate = coordinate
//                annotation.title = "새로운 길냥이"
//                myMap.addAnnotation(annotation)
//               // 좌표에 annotation 추가
            performSegue(withIdentifier: "goToAdd", sender: self)
            
           }
       }

    @IBAction func showCurrentLocation (_ sender: UIButton) {
        locationManager.startUpdatingLocation()
        myMap.isScrollEnabled = true
    }
        

    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue,longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
            myMap.setRegion(pRegion, animated: true)
        return pLocation
    }
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last
            _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue:  (pLocation?.coordinate.longitude)!, delta: 0.01)
        manager.stopUpdatingLocation()
        }
    
    func convertImageToBase64(_ image: UIImage) -> String {
        let imageData:NSData = image.jpegData(compressionQuality: 0.4)! as NSData
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        return strBase64
    }
    
    func convertBase64ToImage(_ str: String) -> UIImage {
        let dataDecoded : Data = Data(base64Encoded: str, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        return decodedimage!
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
          do {
              let catList = try loadMockData()
               // print(catList)
              cats = []
              for cat in catList.cats {
                  print("\(cat.name)")
                cats += [CatAnnotation(title: cat.name, color: cat.color, photo: UIImage(named: "cat1")!, spot: CLLocationCoordinate2D(latitude: cat.spot.coordinate.latitude, longitude: cat.spot.coordinate.longitude), coordinate: CLLocationCoordinate2D(latitude: cat.spot.coordinate.latitude, longitude: cat.spot.coordinate.longitude), details: cat.details, isLiked: cat.isLiked)]
                
            }
                myMap.addAnnotations(cats)
          } catch {
            print(error)
        }
    }
    

    @IBAction func likeFilter(_ sender: UISwitch) {
        if (sender as AnyObject).isOn{
            myMap.removeAnnotations(cats)
            myMap.addAnnotations(cats)
        } else {
            for CatAnnotation in self.myMap.annotations {
             let annotation = CatAnnotation
             if (annotation as? CatAnnotation)?.isLiked == false {
                self.myMap.removeAnnotation(CatAnnotation)
                }
            }
        }
    }
    
    func catAdded() {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

            let file = "savedCats.json"
            let fileURL = dir.appendingPathComponent(file)

            // reading & decoding & addAnnotation
            do {
                let newCatData = try String(contentsOf: fileURL, encoding: .utf8)
                let decoder = JSONDecoder()
                let data = Data(newCatData.utf8)
                let newCat = try decoder.decode(Cat.self, from: data)
                print(newCat) // test
                let newCatMark = CatAnnotation(title: newCat.name, color: newCat.color, photo: convertBase64ToImage(newCat.photo!), spot: CLLocationCoordinate2D(latitude: newCat.spot.coordinate.latitude, longitude: newCat.spot.coordinate.longitude), coordinate: CLLocationCoordinate2D(latitude: newCat.spot.coordinate.latitude, longitude: newCat.spot.coordinate.longitude), details: newCat.details, isLiked: false)
                myMap.addAnnotation(newCatMark)
                print("add cat success")
            }
            catch {
                print("error: \(error)")
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToInfo" {
            _ = segue.destination as! DetailViewController
        } else if segue.identifier == "goToAdd" {
            _ = segue.destination as! AddViewController
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

    if annotation.color == "black" { identifier = "Black"
                   color = .black}
    else if annotation.color == "white" { identifier = "White"
        color = .white}
    else if annotation.color == "orange" { identifier = "Orange"
        color = .orange}
    else if annotation.color == "brown" { identifier = "Brown"
    color = .brown}
    else if annotation.color == "gray" { identifier = "Gray"
    color = .gray}
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
                view.glyphImage = UIImage(named: "CatFace1")
    //            annotationView.glyphTintColor = .yellow
                view.clusteringIdentifier = identifier
    return view
  }
    // 핀의 팝업 혹은 그 안의 i 버튼 클릭하면 디테일 페이지로 넘어감.
    // 여기서 각 핀에 알맞은 데이터를 불러와야 할 듯.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

        performSegue(withIdentifier: "goToInfo", sender: self)

    }
    
    // AddVC로 갔다가 되돌아왔을 떄 실행 (AddVC가 dismiss되면 자동으로 viewWillAppear가 실행됨)
//    override func viewWillAppear(_ animated: Bool){
//
//        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//
//            let file = "savedCats.json"
//            let fileURL = dir.appendingPathComponent(file)
//
//            // reading & decoding & addAnnotation
//            do {
//                let newCatData = try String(contentsOf: fileURL, encoding: .utf8)
//                // print(newCatData) // 정상작동(json String으로 출력) - AddVC의 추가하기가 내려가면 자동으로 출력됨
//                let decoder = JSONDecoder()
//                let data = Data(newCatData.utf8)
//                let newCat = try decoder.decode(Cat.self, from: data) // 이때 리턴하는 photo는 UIImage여야 함
//                print(newCat) // test
//
//                let newCatMark = CatAnnotation(title: newCat.name, color: newCat.color, photo: convertBase64ToImage(newCat.photo!), spot: CLLocationCoordinate2D(latitude: newCat.spot.coordinate.latitude, longitude: newCat.spot.coordinate.longitude), coordinate: CLLocationCoordinate2D(latitude: newCat.spot.coordinate.latitude, longitude: newCat.spot.coordinate.longitude), details: newCat.details, isLiked: newCat.isLiked)
//                myMap.addAnnotation(newCatMark)
//                print("add cat success")
//            }
//            catch {
//                print("error: \(error)")
//            }
//        }
//        print("viewWillAppear") // for test
//    }
}

    
extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

protocol ViewToViewDelegate {
    func catAdded()
}
