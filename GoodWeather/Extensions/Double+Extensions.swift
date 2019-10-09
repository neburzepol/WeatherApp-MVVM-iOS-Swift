//
//  Double+Extensions.swift
//  GoodWeather
//
//  Created by Ali Lopez Galaviz on 10/9/19.
//  Copyright © 2019 Ali López Galaviz. All rights reserved.
//

import Foundation

extension Double {
    
    var formatAsDegree: String {
        return String(format: "%.0f°", self)
    }
    
}
