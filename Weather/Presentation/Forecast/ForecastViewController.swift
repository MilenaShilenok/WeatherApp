//
//  ForecastViewController.swift
//  Weather
//
//  Created by Милена on 18.09.2020.
//  Copyright © 2020 Милена. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController, ForecastViewInput {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var settingsContentView: UIView!
    @IBOutlet weak var refreshContentView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var output: ForecastViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output = ForecastPresenter(view: self)
        setupInitialState()
    }
    
    private func setupInitialState() {
        setupTableView()
        settingsContentView.isHidden = true
        refreshContentView.isHidden = true
        activityIndicator.hidesWhenStopped = true
    }
    
    func forecastDidLoad() {
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.register(ForecastTableViewCell.nib, forCellReuseIdentifier: ForecastTableViewCell.identifier)
    }
    
    func startLoading() {
        tableView.isHidden = true
        refreshContentView.isHidden = true
        settingsContentView.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
        tableView.isHidden = false
        refreshContentView.isHidden = true
        settingsContentView.isHidden = true
    }
    
    func stopLoading(error: Error) {
        show(error: error)
        activityIndicator.stopAnimating()
        tableView.isHidden = true
        refreshContentView.isHidden = false
    }
    
    func authorizationStatusWasDenied() {
        settingsContentView.isHidden = false
        tableView.isHidden = true
        activityIndicator.stopAnimating()
        refreshContentView.isHidden = true
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

extension ForecastViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return output.weatherForecast.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = output.weatherForecast[section]
        return section.keys.first?.description ?? ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = output.weatherForecast[section]
        return section.values.first?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.identifier) as! ForecastTableViewCell
        let wetherValues = output.weatherForecast[indexPath.section].values
        if let forecast = wetherValues.first?[indexPath.row] {
            cell.fill(with: forecast)
        }
        return cell
    }
}
