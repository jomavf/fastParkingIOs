//
//  DetailsViewController.swift
//  fastparking
//
//  Created by Jose Veliz on 6/8/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {
    
    var object: Owner?
    
    private var destination: MKPointAnnotation?
    private var currentRoute: MKRoute?
    
    
    @IBOutlet weak var mapView: MKMapView!
    private let locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D?
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var timeToLabel: UILabel!
    @IBOutlet weak var farFromLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        configureLocationServices()
        loadComponents()
        // Do any additional setup after loading the view.
    }
    
    func loadComponents() {
        if object != nil {
            if let urlImage = self.object!.urlImage {
                mainImageView.setImageFrom(urlString: urlImage, withDefaultNamed: "no-available", withErrorNamed: "no-available")
            }
            if let description = self.object!.description {
                descriptionLabel.text = description
            }
            priceLabel.text = "$12 x hora"
            timeToLabel.text = "36 min."
            farFromLabel.text = "12 Km."
            ratingLabel.text = "5"
        }
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
        let garageAnnotation = MKPointAnnotation()
        guard let longitude = object?.longitude, let latitude = object?.latitude, let fullname = object?.fullName, let description = object?.description else {
            print("No longitude latitude o objectOwner en owner details")
            return
        }
        let ownerCoordinate = CLLocationCoordinate2D(latitude: latitude,longitude: longitude)
        garageAnnotation.coordinate = ownerCoordinate
        garageAnnotation.title = fullname
        garageAnnotation.subtitle = description
        
        destination = garageAnnotation
        
        mapView.addAnnotation(garageAnnotation)
    }
    
    private func contructRoute(userLocation: CLLocationCoordinate2D) {
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
        guard let destination = destination else {return print("Problemas con destination")}
        print("Aqui",userLocation,destination.coordinate,self.object)
        directionRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination.coordinate))
        directionRequest.requestsAlternateRoutes = true
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { [unowned self] (directionsResponse, error) in
            if let error = error {
                print("He aqui el error \(error.localizedDescription)")
            } else if let response = directionsResponse,response.routes.count > 0  {
                self.currentRoute = response.routes[0]
                self.mapView.addOverlay(response.routes[0].polyline)
                self.mapView.setVisibleMapRect(response.routes[0].polyline.boundingMapRect, animated: true)
                
            }
        }
    }
}

extension DetailsViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Ultima ubicacion")
        guard let latestLocation = locations.first else {return}
        
        if currentCoordinate == nil {
            zoomToLatestLocation(with: latestLocation.coordinate)
            createAnnotations()
            contructRoute(userLocation: latestLocation.coordinate)
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

extension DetailsViewController : MKMapViewDelegate {
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
