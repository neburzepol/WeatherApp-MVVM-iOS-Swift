//
//  SettingsViewModel.swift
//  GoodWeather
//
//  Created by Ali Lopez Galaviz on 10/9/19.
//  Copyright © 2019 Ali López Galaviz. All rights reserved.
//

import Foundation

enum Unit: String, CaseIterable {
    case celsius = "metric"
    case fahrenheit = "imperial"
}

extension Unit {
    
    var displayName: String {
        get {
            switch self {
            case .celsius:
                return "Celsius"
            case .fahrenheit:
                return "Fahrenheit"
            }
        }
    }
    
}

struct SettingsViewModel {
    
    let units = Unit.allCases
    
}
