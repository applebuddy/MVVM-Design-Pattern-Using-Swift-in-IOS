//
//  String+Extension.swift
//  GoodWeather
//
//  Created by MinKyeongTae on 2022/10/17.
//

import Foundation

extension String {
  func escaped() -> String  {
    return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
  }
}
