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
        if let navVC = segue.destination as? UINavigationController, let addWeatherVC = navVC.viewControllers.first as? AddWeatherCityViewController {
            addWeatherVC.delegate = self
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
