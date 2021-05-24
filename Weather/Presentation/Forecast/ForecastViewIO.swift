//
//  ForecastViewIO.swift
//  Weather
//
//  Created by Милена on 18.09.2020.
//  Copyright © 2020 Милена. All rights reserved.
//

import Foundation

protocol ForecastViewInput: class, UIViewInput {
    func forecastDidLoad()
    func startLoading()
    func stopLoading()
    func stopLoading(error: Error)
    func authorizationStatusWasDenied()
}

protocol ForecastViewOutput {
    var weatherForecast: [[String: [Weather]]] { get }
    
    func refresh()
}
