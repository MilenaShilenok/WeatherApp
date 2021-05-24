//
//  WeatherService.swift
//  Weather
//
//  Created by Милена on 05.08.2020.
//  Copyright © 2020 Милена. All rights reserved.
//

import UIKit
import CoreLocation

protocol WeatherService {
    func getWeather(coordinate: CLLocationCoordinate2D, completionHandler: @escaping(Weather?, Error?)->Void)
    func getPicture(iconName: String, completionHandler: @escaping(UIImage?, Error?)->Void)
    func getForecast(coordinate: CLLocationCoordinate2D, completionHandler: @escaping([Weather]?, Error?)->Void)
}
