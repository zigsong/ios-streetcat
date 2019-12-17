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
    // 터치한 핀의 좌표값과 비교, 참조하기 위한 좌표들
    var catSpot: [CLLocationCoordinate2D] = []
    var indexOfCat = 0
    
    var location = "marker"
    // var tapCoordinate = CLLocationCoordinate2D(latitude: 37.5, longitude: 126.5) // assign을 바꿔야 할 듯
    
    // AddVC와 롱프레스한 위치를 좌표로 받기 위해 변수 값 설정.
    var longPressedLocation: CLLocationCoordinate2D?
    // DetailVC로 넘어갈 때 참조할 터치한 핀의 좌표를 받기 위한 변수 설정.
    var touchedLocation: CLLocationCoordinate2D?
    let locationManager = CLLocationManager()
    //    let catAnnotations = CatAnnotations()
    
    @IBOutlet weak var myMap: MKMapView!
    
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
            let coordinate = myMap.convert(location,toCoordinateFrom: myMap)
            print("\(coordinate.latitude), \(coordinate.longitude)")
            // 롱프레스한 곳의 좌표를 AddVC에 넘기기 위한 변수 값에 넘김.
            longPressedLocation = coordinate
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
                print("\(cat.spot.coordinate)")
                cats += [CatAnnotation(title: cat.name, color: cat.color, photo: UIImage(named: "cat1")!, spot: CLLocationCoordinate2D(latitude: cat.spot.coordinate.latitude, longitude: cat.spot.coordinate.longitude), coordinate: CLLocationCoordinate2D(latitude: cat.spot.coordinate.latitude, longitude: cat.spot.coordinate.longitude), details: cat.details, isLiked: cat.isLiked)]
                catSpot += [cat.spot.coordinate]
           }
                myMap.addAnnotations(cats)
         } catch {
           print(error)
       }
   }
    
    // remove하면 새로 추가한 핀은 다시 안 생기네요. savedCats의 파일도 별도로 부르는 게 필요함.
    @IBOutlet weak var likeFilterButton: UIButton!

    @IBAction func likeFilter(_ sender: UIButton) {
        if likeFilterButton.isSelected == true {
            myMap.removeAnnotations(cats)
            myMap.addAnnotations(cats)
            //            myMap.addAnnotations(<#T##annotations: [MKAnnotation]##[MKAnnotation]#>)
            likeFilterButton.isSelected = false
        } else {
            for CatAnnotation in self.myMap.annotations {
                let annotation = CatAnnotation
                if (annotation as? CatAnnotation)?.isLiked == false {
                    self.myMap.removeAnnotation(CatAnnotation)
                }
            }
            likeFilterButton.isSelected = true
        }
    }
    // AddVC의 추가가 완료되면 데이터가 인코딩되고 즉시 바로 myMap으로 디코딩할 때, 작동할 catAdded 함수.
    func catAdded() {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

            let file = "savedCats.json"
            let fileURL = dir.appendingPathComponent(file)

            do {
                let newCatData = try String(contentsOf: fileURL, encoding: .utf8)
                let decoder = JSONDecoder()
                let data = Data(newCatData.utf8)
                let newCat = try decoder.decode(Cat.self, from: data)
                // print(newCat) // test
                let newCatMark = CatAnnotation(title: newCat.name, color: newCat.color, photo: convertBase64ToImage(newCat.photo!), spot: CLLocationCoordinate2D(latitude: newCat.spot.coordinate.latitude, longitude: newCat.spot.coordinate.longitude), coordinate: CLLocationCoordinate2D(latitude: newCat.spot.coordinate.latitude, longitude: newCat.spot.coordinate.longitude), details: newCat.details, isLiked: false)
                cats += [newCatMark]
                catSpot += [newCatMark.coordinate]
                myMap.addAnnotation(newCatMark)
                print("add cat success")
            }
            catch {
                print("error: \(error)")
            }
        }
    }
        
    func isLikedSent(_ data: [CatAnnotation]) {
        cats = data
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToInfo", let dest = segue.destination as? DetailViewController {
            
            dest.indexOfCat = indexOfCat
            dest.cats = cats
            dest.delegate = self
        } else if segue.identifier == "goToAdd", let dest = segue.destination as? AddViewController {
            // myMap의 롱프레스 변수를 AddVC에서 쓸 수 있게 AddVC의 롱프레스 변수로 넘겨줌.
            // AddVC의 delegate를 myMap으로 설정.
            dest.longPressedLocation = longPressedLocation
            dest.delegate = self
            
        }
    }
}
    
    
    // DetailVC에서 수정한 isLiked 데이터를 받아오기 위한 함수
<<<<<<< HEAD
=======

>>>>>>> eb502853b23cfdd7933f574ac9b642b8f3d7f901

//MARK: - 이하 extension 및 protocol
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
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

        touchedLocation = view.annotation?.coordinate
        // catSpot에서 탭한 좌표와 일치하는 값을 찾으면 그에 해당하는 ..
        for i in catSpot {
            if i.latitude == touchedLocation!.latitude && i.longitude == touchedLocation!.longitude {
                indexOfCat = catSpot.firstIndex(where: {$0.latitude == touchedLocation!.latitude && $0.longitude == touchedLocation!.longitude}) ?? 0
            }
        }
//        print(touchedLocation)
//        print(catSpot[0])
//        print(catNames)
//        print(indexOfCat)
        
        performSegue(withIdentifier: "goToInfo", sender: self)
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

// 다른 뷰 간에 데이터를 넘겨 받기 위한 delegate 프로토콜
protocol ViewToViewDelegate {
    func catAdded()
    func isLikedSent(_ data: [CatAnnotation])
}
 
