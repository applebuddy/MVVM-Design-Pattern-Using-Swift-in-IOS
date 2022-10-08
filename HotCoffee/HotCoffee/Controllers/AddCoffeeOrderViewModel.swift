//
//  AddCoffeeOrderViewModel.swift
//  HotCoffee
//
//  Created by MinKyeongTae on 2022/10/08.
//

import Foundation

class AddCoffeeOrderViewModel {
  
  var name: String?
  var email: String?
  var types: [String] {
    return CoffeeType.allCases.map { $0.rawValue.capitalized }
  }
  
  var sizes: [String] {
    return CoffeeSize.allCases.map { $0.rawValue.capitalized }
  }
}
