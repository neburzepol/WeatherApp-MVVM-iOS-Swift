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
    private var dataSource: TableViewDataSource<WeatherCell, WeatherViewModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.dataSource = TableViewDataSource(cellIdentifier: "WeatherCell",
                                              items: self.weatherListViewModel.weatherViewModels) { cell, viewModel in
            cell.configure(viewModel)
        }
        self.tableView.dataSource = dataSource
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
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
        weatherListViewModel.addWeatherViewModel(vm)
        self.dataSource?.updateItems(weatherListViewModel.weatherViewModels)
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
