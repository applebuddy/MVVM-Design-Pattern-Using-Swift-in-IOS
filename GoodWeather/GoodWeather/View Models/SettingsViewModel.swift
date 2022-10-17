//
//  SettingsViewModel.swift
//  GoodWeather
//
//  Created by MinKyeongTae on 2022/10/17.
//

import Foundation

enum Unit: String, CaseIterable {
  case celsius = "metric"
  case fahrenheit = "imperial"
}

extension Unit {
  var displayName: String {
    get {
      switch(self) {
      case .celsius:
        return "Celcius"
      case .fahrenheit:
        return "Fahrenheit"
      }
    }
  }
}

class SettingsViewModel {
  let units = Unit.allCases
  var selectedUnit: Unit {
    get {
      let userDefaults = UserDefaults.standard
      var unitValue = ""
      if let value = userDefaults.value(forKey: "unit") as? String {
        unitValue = value
      } else {
        userDefaults.set(Unit.celsius, forKey: "unit")
      }
      return Unit(rawValue: unitValue) ?? .celsius
    }
    set {
      let userDefaults = UserDefaults.standard
      userDefaults.set(newValue.rawValue, forKey: "unit")
    }
  }
}
