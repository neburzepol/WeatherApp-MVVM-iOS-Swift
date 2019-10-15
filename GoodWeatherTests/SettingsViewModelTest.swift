//
//  SettingsViewModelTest.swift
//  GoodWeatherTests
//
//  Created by Ali Lopez Galaviz on 10/14/19.
//  Copyright © 2019 Ali López Galaviz. All rights reserved.
//

import XCTest
@testable import GoodWeather

class SettingsViewModelTest: XCTestCase {

    private var settingsVM: SettingsViewModel!
    
    override func setUp() {
        super.setUp()
        self.settingsVM = SettingsViewModel()
    }
    
    func test_should_make_sure_that_default_selected_unit_is_fahrenheit() {
        XCTAssertEqual(settingsVM.selectedUnit, .fahrenheit)
    }
    
    func test_should_return_correct_display_name_for_fahrenheit() {
        XCTAssertEqual(settingsVM.selectedUnit.displayName, "Fahrenheit")
    }
    
    func test_should_be_able_to_save_user_unit_selection() {
        self.settingsVM.selectedUnit = .celsius
        let userDefaults = UserDefaults.standard
        XCTAssertNotNil(userDefaults.value(forKey: "unit"))
    }
    
    override func tearDown() {
        super.tearDown()
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "unit")
    }

}
