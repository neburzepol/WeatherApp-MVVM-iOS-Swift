//
//  WeatherListTableViewController.swift
//  GoodWeather
//
//  Created by Ali Lopez Galaviz on 10/8/19.
//  Copyright © 2019 Ali López Galaviz. All rights reserved.
//

import Foundation
import UIKit

class WeatherListTableViewController: UITableViewController {
    
    private var weatherListViewModel = WeatherListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherListViewModel.numberOfRows(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell else {
            fatalError("WeatherCell not found")
        }
        let weatherVM = weatherListViewModel.modelAt(indexPath.row)
        cell.configure(weatherVM)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddWeatherCityViewController" {
            prepareSegueForAddWeatherCityViewController(segue: segue)
        } else if segue.identifier == "SettingsTableViewController" {
            prepareSegueForSettingsViewController(segue: segue)
        } else if segue.identifier == "WeatherDetailsViewController" {
            prepareSegueForWeatherDetailsViewController(segue: segue)
        }
    }
    
    private func prepareSegueForAddWeatherCityViewController(segue: UIStoryboardSegue) {
        if let navVC = segue.destination as? UINavigationController, let addWeatherVC = navVC.viewControllers.first as? AddWeatherCityViewController {
            addWeatherVC.delegate = self
        }
    }
    
    private func prepareSegueForSettingsViewController(segue: UIStoryboardSegue) {
        if let navVC = segue.destination as? UINavigationController, let settingsVC = navVC.viewControllers.first as? SettingsTableViewController {
            settingsVC.delegate = self
        }
    }
    
    private func prepareSegueForWeatherDetailsViewController(segue: UIStoryboardSegue) {
        if let weatherDetails = segue.destination as? WeatherDetailsViewController, let indexPath = tableView.indexPathForSelectedRow {
            let weatherVM = self.weatherListViewModel.modelAt(indexPath.row)
            weatherDetails.weatherViewModel = weatherVM
        }
    }
    
}

extension WeatherListTableViewController: AddWeatherDelegate {
    
    func addWeatherDidSave(viewController: UIViewController, vm: WeatherViewModel) {
        viewController.dismiss(animated: true, completion: nil)
        weatherListViewModel.addWeatherViewModel(vm: vm)
        self.tableView.reloadData()
    }
    
}

extension WeatherListTableViewController: SettingsDelegate {
    
    func settingsDone(viewController: UIViewController, vm: SettingsViewModel) {
        viewController.dismiss(animated: true)
        self.weatherListViewModel.updateUnit(to: vm.selectedUnit)
        self.tableView.reloadData()
    }
    
}
