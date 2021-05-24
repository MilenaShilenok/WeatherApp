//
//  Double+fromKelvinToC.swift
//  Weather
//
//  Created by Милена on 21.09.2020.
//  Copyright © 2020 Милена. All rights reserved.
//

import Foundation

extension Double {
    func fromKelvinToCelsius() -> Int {
        let tempCelsius = (self - 273.15).rounded(.toNearestOrEven)
        return Int(tempCelsius)
    }
}
