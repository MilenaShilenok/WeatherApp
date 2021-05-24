//
//  UIViewController+showAlert.swift
//  Weather
//
//  Created by Милена on 12.05.2021.
//  Copyright © 2021 Милена. All rights reserved.
//

import UIKit

extension UIViewController {
    // TODO: remane
    func showAlert() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        let title = String.Alert.locationAccessRequired
        let message = String.Alert.allowLocationAccess
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let closeAction = UIAlertAction(title: String.Alert.close, style: .cancel, handler: nil)
        alert.addAction(closeAction)
        
        let settingsAction = UIAlertAction(title: String.Alert.settings, style: .default, handler: {action in
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        })
        alert.addAction(settingsAction)

        self.present(alert, animated: true)
    }
}
