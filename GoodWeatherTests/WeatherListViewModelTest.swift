//
//  WeatherListViewModelTest.swift
//  GoodWeatherTests
//
//  Created by Ali Lopez Galaviz on 10/14/19.
//  Copyright © 2019 Ali López Galaviz. All rights reserved.
//

import XCTest
@testable import GoodWeather

class WeatherListViewModelTest: XCTestCase {

    private var weatherListViewModel: WeatherListViewModel!
    
    override func setUp() {
        super.setUp()
        self.weatherListViewModel = WeatherListViewModel()
        
        self.weatherListViewModel.addWeatherViewModel(WeatherViewModel(name: Dynamic("Chihuahua"), currentTemperature: TemperatureViewModel(temperature: Dynamic(32.0), temperatureMin: Dynamic(0.0), temperatureMax: Dynamic(0.0))))
        
        self.weatherListViewModel.addWeatherViewModel(WeatherViewModel(name: Dynamic("Madera"), currentTemperature: TemperatureViewModel(temperature: Dynamic(72), temperatureMin: Dynamic(0.0), temperatureMax: Dynamic(0.0))))
        
    }
    
    func test_should_be_able_to_convert_tocelsius_successfully() {
        
        let celsiusTemperatures = [0, 22.2222]
        self.weatherListViewModel.updateUnit(to: .celsius)
        for (index, vm) in self.weatherListViewModel.weatherViewModels.enumerated() {
            XCTAssertEqual(round( vm.currentTemperature.temperature.value), round(celsiusTemperatures[index]))
        }
        
    }
    
    override func tearDown() {
        super.tearDown()
    }

}
