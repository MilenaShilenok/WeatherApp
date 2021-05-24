//
//  UIViewInput.swift
//  Weather
//
//  Created by Милена on 21.09.2020.
//  Copyright © 2020 Милена. All rights reserved.
//

import UIKit
import Alamofire

protocol UIViewInput {
    func show(error: Error)
}

extension UIViewInput {
    func show(error: Error) {
        guard let vc = self as? UIViewController else { return }
        let alert = UIAlertController(title: String.Error.error, message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: String.Error.ok, style: .default, handler: nil)
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
    
}
