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

    let dispatchGroup = DispatchGroup()
    var index:Int?
    
    @IBOutlet weak var mapView: MKMapView!

    var locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D?
    
    var owners: [Owner] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        configureLocationServices()
        
        dispatchGroup.enter()
        fastParkingAPI.getOwners(responseHandler: responseHandler, errorHandler: errorHandler)
        
        dispatchGroup.notify(queue: .main) {
            self.createAnnotations()
        }
    }
    
    func getOwner(_ id:Int)->Owner{
        var choosen:Owner?
        for owner in self.owners {
            if(owner.id == id){
                choosen = owner
            }
        }
        
        return choosen!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Executing prepare for")
        let vc = segue.destination as? DetailsViewController
        if vc != nil {
            guard let index = self.index else {return print("No index set")}
            let owner = self.getOwner(index)
            vc!.object = owner
        }
        
    }
    
    func responseHandler(data:OwnerResponse) {
        if data.owners != nil {
            self.owners = data.owners!
            dispatchGroup.leave()
        } else {
            print("No data or problems with responseHandler function")
            dispatchGroup.leave()
        }
    }
    
    func errorHandler(error:Error) {
        let message="Error on sources request: \(error.localizedDescription)"
        print(message)
        dispatchGroup.leave()
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
            let newAnnotation = MKPointAnnotation()
            if let fullname = owner.fullName, let lon = owner.longitude, let lat = owner.latitude {
                newAnnotation.title = fullname
                newAnnotation.subtitle = String(owner.id)
                newAnnotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                ownersAnnotations.append(newAnnotation)
            } else {
                print("ZetaGH ERROR: Some owner has no lat no log or no fullname")
            }
        }
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
        }

        currentCoordinate = latestLocation.coordinate
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdates(locationManager: manager)
        }
    }
}

extension ViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        
        if ( annotationView == nil ) {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        }
        
        if annotation !== mapView.userLocation {
            annotationView?.image = UIImage(named: "spot")
            let infoButton = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = infoButton

        } else {
            annotationView?.image = UIImage(named: "car")
        }
        
        annotationView?.canShowCallout = true
        return annotationView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("1")
        guard let annotation = view.annotation else {return}
        print("2")
//        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)

        let id  =  annotation.subtitle!
        self.index = Int(id!)
        
        self.performSegue(withIdentifier: "goToFuckingDetails", sender: self)
        
        
        // anterior si funcionaba
//        if let _ = self.index {
//            if let detailsViewController = (mainStoryBoard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController) {
//                detailsViewController.object = self.getOwner(self.index!)
//                let navController = UINavigationController(rootViewController: detailsViewController)
//
//            navController.navigationBar.backItem?.backBarButtonItem = UIBarButtonItem(title: "Map", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
//
//
//
//                self.present(navController, animated: true, completion: nil)
//            }
//        }
    }
    
}
