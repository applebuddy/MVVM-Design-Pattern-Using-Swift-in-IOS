//
//  Double+Extension.swift
//  GoodWeather
//
//  Created by MinKyeongTae on 2022/10/17.
//

import Foundation

extension Double {
  func formatAsDegree() -> String {
    return String(format: "%.0f℃", self)
  }
}
