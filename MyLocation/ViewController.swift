//
//  ViewController.swift
//  MyLocation
//
//  Created by Pavlo Novak on 4/12/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

// import mapkit corelocation
// create mkpointannotation & CLLocationManeger
// add locmanagerDelegate & mkmapviewdelegate
// initialize in ViewDL manager and delegate of mapview.self
// add in Info.plist location ns bla bla
// location manager requestWhenInUse
// initialize annotation based on class file
// add annotation to mapView
// didChange
// didUpdateLocations
// didFailWithError
// viewFor annotation makes a bubble for u

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager?
    let annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        mapView.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager?.startUpdatingLocation()
        } else {
            locationManager?.requestWhenInUseAuthorization()
        }
        let annotation = Annotation(title: "Andersen", locationName: "IT-company", picture: UIImage(named: "Andersen")!, coordinate: (locationManager?.location?.coordinate)!)
        mapView.addAnnotation(annotation)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            print("NotDetermined")
            locationManager?.requestWhenInUseAuthorization()
        case .restricted:
            print("Restricted")
        case .denied:
            print("Denied")
        case .authorizedAlways:
            print("AuthorizedAlways")
        case .authorizedWhenInUse:
            print("AuthorizedWhenInUse")
            locationManager!.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 500, 500)
            mapView.setRegion(coordinateRegion, animated: true)
            locationManager?.stopUpdatingLocation()
            locationManager = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("failed to find location: \(error.localizedDescription)")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? Annotation else { return nil }
        
        let identifier = "andersen"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            view.leftCalloutAccessoryView = UIImageView.init(image: annotation.picture)
        }
        return view
    }
}
