//
//  ForecastPresenter.swift
//  Weather
//
//  Created by Милена on 18.09.2020.
//  Copyright © 2020 Милена. All rights reserved.
//

import Foundation
import CoreLocation

class ForecastPresenter: ForecastViewOutput {
  
    let weatherService: WeatherService = WeatherServiceImp.instance
    let locationService: LocationService = LocationServiceImp.instance
    weak var view: ForecastViewInput!
    var weatherForecast: [[String: [Weather]]] = []
    
    init(view: ForecastViewInput) {
        self.view = view
        locationService.register(observer: self)
    }
    
    func getForecast(coordinate: CLLocationCoordinate2D) {
        view.startLoading()
        weatherService.getForecast(coordinate: coordinate) { [weak self] (arrayForecast, error) in
            if let arrayForecast = arrayForecast {
                self?.toFormData(arrayForecast: arrayForecast)
                self?.view.stopLoading()
            }
            if let error = error {
                self?.view.stopLoading(error: error)
            }
        }
    }
    
    private func toFormData(arrayForecast: [Weather]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        var massDict: [[String: [Weather]]] = []
        arrayForecast.forEach { (weather) in
            var index = 0
            let dayStr = dateFormatter.string(from: weather.date)
            
            while index != massDict.count && massDict[index][dayStr]?.append(weather) == nil {
                index += 1
            }
            if index == massDict.count {
                let dict = [dayStr: [weather]]
                massDict.append(dict)
            }
        }
        weatherForecast = massDict
        view.forecastDidLoad()
    }
    
    func refresh() {
        if let coordinate = locationService.currentCoordinate {
            getForecast(coordinate: coordinate)
        } else {
            view.show(error: SystemError.failedToGetCoordinates)
        }
    }
}

extension ForecastPresenter: LocationObserver {
    func didFailWith(_ error: Error) {
        view.show(error: error)
    }
    
    func didReceive(_ coordinate: CLLocationCoordinate2D) {
        getForecast(coordinate: coordinate)
    }
    
    func authorizationStatusWasDenied() {
        view.authorizationStatusWasDenied()
    }
}
