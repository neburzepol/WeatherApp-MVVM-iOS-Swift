//
//  WeatherListViewModel.swift
//  GoodWeather
//
//  Created by Ali Lopez Galaviz on 10/8/19.
//  Copyright © 2019 Ali López Galaviz. All rights reserved.
//

import Foundation

struct WeatherListViewModel {
    
    private var weatherViewModels = [WeatherViewModel]()
    
    mutating func addWeatherViewModel(vm: WeatherViewModel) {
        self.weatherViewModels.append(vm)
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return self.weatherViewModels.count
    }
    
    func modelAt(_ index: Int) -> WeatherViewModel {
        return weatherViewModels[index]
    }
    
    mutating private func toCelsius() {
        weatherViewModels = weatherViewModels.map { vm in
            var weatherModel = vm
            weatherModel.currentTemperature.temperature = ((weatherModel.currentTemperature.temperature-32) * 5/9)
            return weatherModel
        }
    }
    
    mutating private func toFahrenheit() {
        weatherViewModels = weatherViewModels.map { vm in
            var weatherModel = vm
            weatherModel.currentTemperature.temperature = ((weatherModel.currentTemperature.temperature * 9/5) + 32)
            return weatherModel
        }
    }
    
    mutating func updateUnit(to unit: Unit) {
        switch unit {
        case .celsius:
            toCelsius()
        case .fahrenheit:
            toFahrenheit()
        }
    }
    
}

struct WeatherViewModel: Decodable {
    
    var name: String
    var currentTemperature: TemperatureViewModel
    
}

extension WeatherViewModel {
    
    private enum CondingKeys: String, CodingKey {
        case name
        case currentTemperature = "main"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CondingKeys.self)
        let name: String = try container.decode(String.self, forKey: .name)
        let currentTemperature: TemperatureViewModel = try container.decode(TemperatureViewModel.self, forKey: .currentTemperature)
        self.init(name: name, currentTemperature: currentTemperature)
    }
    
    
}

struct TemperatureViewModel: Decodable {
    
    var temperature: Double
    let temperatureMin: Double
    let temperatureMax: Double
    
}

extension TemperatureViewModel {
    
    private enum CondingKeys: String, CodingKey {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CondingKeys.self)
        let temperature: Double = try container.decode(Double.self, forKey: .temperature)
        let temperatureMin: Double = try container.decode(Double.self, forKey: .temperatureMin)
        let temperatureMax: Double = try container.decode(Double.self, forKey: .temperatureMax)
        self.init(temperature: temperature, temperatureMin: temperatureMin, temperatureMax: temperatureMax)
    }
    
}
