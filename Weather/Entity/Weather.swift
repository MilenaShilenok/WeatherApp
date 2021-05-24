//
//  WeatherStruct.swift
//  Weather
//
//  Created by Милена on 05.08.2020.
//  Copyright © 2020 Милена. All rights reserved.
//

import Foundation

struct Weather {
    let temp: Double
    let date: Date
    let description: String
    let iconName: String
    let pressure: Double
    let humidity: Double
    let speedWind: Double
    let minTemp: Double
    let maxTemp: Double
    
    init(dict: [String: Any]) throws {
        guard let weather = (dict["weather"] as? [Any])?.first as? [String: Any],
            let description = weather["description"] as? String,
            let icon = weather["icon"] as? String,
            let dt = dict["dt"] as? Double,
            let main = dict["main"] as? [String: Any],
            let pressure = main["pressure"] as? Double,
            let humidity = main["humidity"] as? Double,
            let minTemp = main["temp_min"] as? Double,
            let maxTemp = main["temp_max"] as? Double,
            let temp = main["temp"] as? Double,
            let wind = dict["wind"] as? [String: Any],
            let speedWind = wind["speed"] as? Double else {
                throw SystemError.errorMapping
        }
        let date = Date(timeIntervalSince1970: dt)
        
        self.temp = temp
        self.description = description
        self.iconName = icon
        self.pressure = pressure
        self.humidity = humidity
        self.speedWind = speedWind
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.date = date
    }
}


