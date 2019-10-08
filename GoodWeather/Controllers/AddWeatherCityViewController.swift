//
//  AddWeatherCityViewController.swift
//  GoodWeather
//
//  Created by Ali Lopez Galaviz on 10/8/19.
//  Copyright © 2019 Ali López Galaviz. All rights reserved.
//

import Foundation
import UIKit

class AddWeatherCityViewController: UIViewController {
    
    @IBOutlet weak var cityNameTextField: UITextField!
    
    @IBAction func saveCityButtonPressed() {
        
        if let city = cityNameTextField.text {
            let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=d14a962f6b51e76762f3ea037586dc17")!
            
            let weatherResource = Resource<Any>(url: weatherURL) { data in
                return data
            }
            
            WebService().load(resource: weatherResource) { result in
                
            }
        }
        
    }
    
    @IBAction func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
