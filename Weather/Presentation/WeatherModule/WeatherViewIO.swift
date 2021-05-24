//
//  WeatherViewIO.swift
//  Weather
//
//  Created by Милена on 05.08.2020.
//  Copyright © 2020 Милена. All rights reserved.
//

import UIKit
import CoreLocation

protocol WeatherViewInput: class, UIViewInput {
    func fillData(weather: Weather)
    func displayImage(image: UIImage)
    func startLoading()
    func stopLoading()
    func stopLoading(with error: Error)
    func authorizationStatusWasDenied()
}

protocol WeatherViewOutput {
    func getWeather(coordinate: CLLocationCoordinate2D)
    func refresh()
}
