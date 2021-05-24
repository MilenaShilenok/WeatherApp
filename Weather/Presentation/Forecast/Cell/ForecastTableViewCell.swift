//
//  ForecastTableViewCell.swift
//  Weather
//
//  Created by Милена on 18.09.2020.
//  Copyright © 2020 Милена. All rights reserved.
//

import UIKit
import Kingfisher

class ForecastTableViewCell: UITableViewCell {
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func fill(with weather: Weather) {
        self.tempLabel.text = Int(round(weather.temp - 273.15)).description + " Cº"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let dateText = formatter.string(from: weather.date)
        self.dateLabel.text = dateText
        self.descriptionLabel.text = weather.description
       
        let url = URL(string: "https://openweathermap.org/img/wn/" + weather.iconName + "@2x.png")
        weatherIconImageView.kf.setImage(with: url)
    }
}
