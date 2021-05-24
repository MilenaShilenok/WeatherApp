//
//  WeatherServiceImp.swift
//  Weather
//
//  Created by Милена on 05.08.2020.
//  Copyright © 2020 Милена. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

class WeatherServiceImp: WeatherService {
    
    static let instance = WeatherServiceImp()

    private init() {}
    
    let baseURL = "https://api.openweathermap.org/"
    let appid = "29c3f050576d65efdd7d3cee5cbcce56"

    func getWeather(coordinate: CLLocationCoordinate2D, completionHandler: @escaping(Weather?, Error?)->Void) {
        // base url
        let url = baseURL + "data/2.5/weather"
        let params: Parameters = ["appid": appid, "lon": coordinate.longitude, "lat": coordinate.latitude]
        AF.request(url, parameters: params).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                do {
                    guard let dict = value as? [String: Any] else { return } 
                    let weather = try Weather(dict: dict)
                    completionHandler(weather, nil)
                } catch {
                    completionHandler(nil, SystemError.default)
                }
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    func getPicture(iconName: String, completionHandler: @escaping(UIImage?, Error?)->Void) {
        let url = "https://openweathermap.org/img/wn/" + iconName + "@2x.png"
        AF.request(url).validate().responseData { (response) in
            switch response.result {
            case .success(let value):
                let image = UIImage(data: value)
                completionHandler(image, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    func getForecast(coordinate: CLLocationCoordinate2D, completionHandler: @escaping([Weather]?, Error?)->Void) {
        
        let url = baseURL + "data/2.5/forecast"
        let params: Parameters = ["appid": appid, "lon": coordinate.longitude, "lat": coordinate.latitude]
        AF.request(url, parameters: params).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                var weatherForecast: [Weather] = []

                guard let dict = value as? [String: Any],
                      let massForecast = dict["list"] as? [[String:Any]] else {
                    completionHandler(nil, SystemError.errorMapping)
                    return
                }
                
                do {
                    try massForecast.forEach { (element) in
                        let weather = try Weather(dict: element)
                        weatherForecast.append(weather)
                    }
                    completionHandler(weatherForecast, nil)
                } catch {
                    completionHandler(nil, SystemError.default)
                }
 
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
