//
//  SystemError.swift
//  Weather
//
//  Created by Милена on 11.09.2020.
//  Copyright © 2020 Милена. All rights reserved.
//

import Foundation

enum SystemError: LocalizedError {
    case `default`
    case errorMapping
    case failedToGetCoordinates
    case custom(String)
  
    var errorDescription: String? {
        switch self {
        case .default:
            return String.Error.somethingWentWrong
        case .errorMapping:
            return String.Error.errorMapping
        case .failedToGetCoordinates:
            return String.Error.failedToGetCoordinates
        case .custom(let message):
            return message
        }
    }
}
