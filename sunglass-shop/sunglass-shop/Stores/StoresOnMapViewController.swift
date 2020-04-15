//
//  StoresOnMapViewController.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-04.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class StoresOnMapViewController: UIViewController {
    
    // MARK: Properties
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 50000
    
    // MARK: IBOutlets
    
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        getStores()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func centerViewOnUserLocation() {
        if let location =  locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            let errorAlert = UIAlertController(title: "Device location are not available", message: "Locationservices is not eneabled on your device.", preferredStyle: .alert)
            present(errorAlert, animated: true, completion: nil)
        }
    }
    
    private func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .authorizedAlways:
            break
        }
    }
}

// MARK: CLLocationManagerDelegate

extension StoresOnMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
//        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}


// MARK: Annotations

extension StoresOnMapViewController {
    
    private func getStores() {
        NetworkManager.shared.getStores { (stores, error) in
            if let error = error {
                let errorAlert = UIAlertController(title: "", message: error.localizedDescription, preferredStyle: .alert)
                self.present(errorAlert, animated: true, completion: nil)
            }
            
            DispatchQueue.main.async {
                self.layoutAnnotations(for: stores)
            }
        }
    }
    
    private func layoutAnnotations(for stores: [Store]) {
        var annotations = [MKAnnotation]()
        
        for store in stores {
            let annotation = MKPointAnnotation()
            annotation.title = store.title
            print(annotation.title)
            annotation.coordinate = store.coordinates
            print(store.coordinates)
            annotations.append(annotation)
        }
        
        mapView.addAnnotations(annotations)
    }
}
