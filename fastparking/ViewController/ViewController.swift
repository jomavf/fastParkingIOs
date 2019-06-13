//
//  ViewController.swift
//  fastparking
//
//  Created by Jose Veliz on 6/6/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D?
    private var destination: MKPointAnnotation?
    private var currentRoute: MKRoute?
    
    var owners: [Owner] = []
    
//    func checkLocationAuthorizationStatus(){
//        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
//            mapView.showsUserLocation = true
//        } else {
//            locationManager.requestWhenInUseAuthorization()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        configureLocationServices()
        fastParkingAPI.getOwners(responseHandler: responseHandler, errorHandler: errorHandler)
        //        let peru = Place(title: "Peru", coordinate: CLLocationCoordinate2D(latitude: 48, longitude: 2), info:  "Futuro peru")
        //        let chile = Place(title: "Chile", coordinate: CLLocationCoordinate2D(latitude: 41, longitude: 12), info:  "Chile")
        
        //        mapView.addAnnotations([peru,chile])
        //        mapView.showAnnotations(mapView.annotations, animated: true)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func responseHandler(data:OwnerResponse) {
        if data.owners != nil {
            self.owners = data.owners!
        } else {
            print("No data or problems with responseHandler function")
        }
    }
    
    func errorHandler(error:Error) {
        let message="Error on sources request: \(error.localizedDescription)"
        print(message)
    }
    
    private func configureLocationServices() {
        locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdates(locationManager: locationManager)
        }
    }
    
    private func zoomToLatestLocation(with coordinate:CLLocationCoordinate2D){
        let zoomRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(zoomRegion, animated: true)
    }
    
    private func beginLocationUpdates(locationManager:CLLocationManager){
        mapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    private func createAnnotations() {
        var ownersAnnotations: [MKPointAnnotation] = []
        for owner in owners {
            var newAnnotation = MKPointAnnotation()
            if let fullname = owner.fullName, let lon = owner.longitude, let lat = owner.latitude {
                newAnnotation.title = fullname
                newAnnotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                ownersAnnotations.append(newAnnotation)
            } else {
                print("skipped")
            }
        }
//        let garageAnnotation = MKPointAnnotation()
//        guard let longitude = object?.longitude, let latitude = object?.latitude, let fullname = object?.fullName, let description = object?.description else {
//            print("No longitude latitude o objectOwner en owner details")
//            return
//        }
//        let ownerCoordinate = CLLocationCoordinate2D(latitude: latitude,longitude: longitude)
//        garageAnnotation.coordinate = ownerCoordinate
//        garageAnnotation.title = fullname
//        garageAnnotation.subtitle = description
//
//        destination = garageAnnotation
        for annotation in ownersAnnotations {
            mapView.addAnnotation(annotation)
        }
        
    }

}
extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else {return}

        if currentCoordinate == nil {
            zoomToLatestLocation(with: latestLocation.coordinate)
//            createAnnotations()
//            contructRoute(userLocation: latestLocation.coordinate)
        }

        currentCoordinate = latestLocation.coordinate
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("status changed")
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdates(locationManager: manager)
        }
    }
}
//extension ViewController : MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        guard annotation is Place else { return nil }
//        let identifier = "Place"
//        var annotationView  = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//        if annotationView == nil {
//            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            annotationView?.canShowCallout = true
//            let infoButton = UIButton(type: .detailDisclosure)
//            annotationView?.rightCalloutAccessoryView = infoButton
//        } else {
//            annotationView?.annotation = annotation
//        }
//        return annotationView
//    }
//
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        guard let place = view.annotation as? Place else {return}
//        let placeTitle = place.title
//        let placeInfo = place.info
//        let alert = UIAlertController(title: placeTitle, message: placeInfo, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
//    }
//
//}

extension ViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let currentRoute = currentRoute else {
            return MKOverlayRenderer()
        }
        let polyLineRenderer = MKPolylineRenderer(polyline: currentRoute.polyline)
        polyLineRenderer.strokeColor = UIColor.blue
        polyLineRenderer.lineWidth = 5
        return polyLineRenderer
    }
}
