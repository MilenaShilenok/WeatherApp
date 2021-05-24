//
//  LocationService.swift
//  Weather
//
//  Created by Милена on 05.08.2020.
//  Copyright © 2020 Милена. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationService {
    func register(observer: LocationObserver)
    func remove(observer: LocationObserver)
    var currentCoordinate: CLLocationCoordinate2D? { get }
}
