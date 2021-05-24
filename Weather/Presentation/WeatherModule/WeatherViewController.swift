//
//  ViewController.swift
//  Weather
//
//  Created by Милена on 31.07.2020.
//  Copyright © 2020 Милена. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, WeatherViewInput {
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var speedWindLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var mainContentView: UIView!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var settinsContentView: UIView!
    @IBOutlet weak var refreshContentView: UIView!
    
    var output: WeatherViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()        
        output = WeatherPresenter(view: self)
        setupInitialState()
    }
    
    private func setupInitialState() {
        refreshContentView.isHidden = true
        activityIndicator.hidesWhenStopped = true
        settinsContentView.isHidden = true
        startLoading()
    }
    
    func fillData(weather: Weather) {
        tempLabel.text = weather.temp.fromKelvinToCelsius().description + "°"

        descriptionLabel.text = weather.description
        pressureLabel.text = Int(round(weather.pressure)).description + " мм рт. ст."
        humidityLabel.text = Int(round(weather.humidity)).description + "%"
       
        speedWindLabel.text = Int(round(weather.speedWind)).description + " м/с"
        minTempLabel.text = weather.temp.fromKelvinToCelsius().description + " Cº" 
        maxTempLabel.text = weather.temp.fromKelvinToCelsius().description + " Cº"
    }
    
    func displayImage(image: UIImage) {
        self.imageView.image = image
    }
    
    func startLoading() {
        mainContentView.isHidden = true
        refreshContentView.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        refreshContentView.isHidden = true
        mainContentView.isHidden = false
        activityIndicator.stopAnimating()
    }
    
    func stopLoading(with error: Error) {
        show(error: error)
        activityIndicator.stopAnimating()
        mainContentView.isHidden = true
        refreshContentView.isHidden = false
    }
    
    func authorizationStatusWasDenied() {
        activityIndicator.stopAnimating()
        mainContentView.isHidden = true
        refreshContentView.isHidden = true
        settinsContentView.isHidden = false
    }
    
    @IBAction func openSettings(_ sender: Any) {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func refresh(_ sender: Any) {
        output.refresh()
    }
}

