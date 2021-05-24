//
//  WeatherPresenter.swift
//  Weather
//
//  Created by Милена on 05.08.2020.
//  Copyright © 2020 Милена. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherPresenter: NSObject, WeatherViewOutput, CLLocationManagerDelegate {

    weak var view: WeatherViewInput!
    let weatherService: WeatherService = WeatherServiceImp.instance
    let locationService: LocationService = LocationServiceImp.instance

    init(view: WeatherViewInput) {
        super.init()
        self.view = view
        locationService.register(observer: self)
    }
    
    func getWeather(coordinate: CLLocationCoordinate2D) {
        view.startLoading()
        weatherService.getWeather(coordinate: coordinate) { [weak self] (weather, error) in
            if let error = error {
                self?.view.stopLoading(with: error)
            }
            
            if let weather = weather {
                self?.getImage(weather.iconName)
                self?.view.fillData(weather: weather)
                self?.view.stopLoading()
            }
        }
    }
    
    private func getImage(_ name: String) {
        weatherService.getPicture(iconName: name) { [weak self] (image, error) in
            if let error = error {
                self?.view.show(error: error)
            }
            
            if let image = image {
                self?.view.displayImage(image: image)
            }
        }
    }
    
    func refresh() {
        if let coordinate = locationService.currentCoordinate {
            getWeather(coordinate: coordinate)
        } else {
            view.show(error: SystemError.failedToGetCoordinates)
        }
    }
}

extension WeatherPresenter: LocationObserver {
    func didFailWith(_ error: Error) {
        view.show(error: error)
    }
    
    func didReceive(_ coordinate: CLLocationCoordinate2D) {
        getWeather(coordinate: coordinate)
    }
    
    func authorizationStatusWasDenied() {
        view.authorizationStatusWasDenied()
    }
   
}
