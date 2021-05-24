//
//  WeatherServiceImp.swift
//  Weather
//
//  Created by Милена on 05.08.2020.
//  Copyright © 2020 Милена. All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationObserver: class {
    func didReceive(_ coordinate: CLLocationCoordinate2D)
    func authorizationStatusWasDenied()
    func didFailWith(_ error: Error)
}

struct WeakBox {
    weak var object: AnyObject?
}

class LocationServiceImp: NSObject, CLLocationManagerDelegate, LocationService {
    private var observers: [WeakBox] = []

    let locationManager = CLLocationManager()
    static let instance = LocationServiceImp()
    
    var currentCoordinate: CLLocationCoordinate2D? {
        return locationManager.location?.coordinate
    }
    
    private override init() {
        super.init()
        locationManager.delegate = self
    }
    
    private func setUpLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.distanceFilter = 1000
            locationManager.startUpdatingLocation()
        }
    }
    
    func register(observer: LocationObserver) {
        let isContains = observers.contains { (object) -> Bool in
            return object.object === observer
        }
        
        if isContains {
            return
        }
      
        let weakBox = WeakBox(object: observer)
        observers.append(weakBox)
        
        if let coordinate = locationManager.location?.coordinate {
            observer.didReceive(coordinate)
        }
        
        let status = CLLocationManager.authorizationStatus()
        if status == .denied {
            observer.authorizationStatusWasDenied()
        }
    }
    
    func remove(observer: LocationObserver) {
        let weakBox = WeakBox(object: observer)
        observers.removeAll { (object) -> Bool in
            object.object === weakBox.object
        }
    }
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.last?.coordinate else { return }
        observers.forEach { (observer) in
            let object = observer.object as? LocationObserver
            object?.didReceive(coordinate)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        observers.forEach { (observer) in
            let object = observer.object as? LocationObserver
            object?.didFailWith(error)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = CLLocationManager.authorizationStatus()

        switch status {
        case .denied:
            observers.forEach { (observer) in
                let objct = observer.object as? LocationObserver
                objct?.authorizationStatusWasDenied()
            }
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            setUpLocationManager()
        default:
            return
        }
    }
}
