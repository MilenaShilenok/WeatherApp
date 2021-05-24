//
//  String.swift
//  Weather
//
//  Created by Милена on 12.05.2021.
//  Copyright © 2021 Милена. All rights reserved.
//

import Foundation

extension String {
    struct Alert {
        static let locationAccessRequired = "Location access required to get weather forecast."
        static let allowLocationAccess = "Please allow location access."
        static let settings = "Settings"
        static let close = "Close"
    }
    
    struct Error {
        static let error = "Error"
        static let ok = "Ok"
        static let errorMapping = "Error mapping"
        static let somethingWentWrong = "Something went wrong. Try again later"
        static let failedToGetCoordinates = "Failed to get coordinates"
    }
}
