//
//  File.swift
//  Weather
//
//  Created by Милена on 09.05.2021.
//  Copyright © 2021 Милена. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
