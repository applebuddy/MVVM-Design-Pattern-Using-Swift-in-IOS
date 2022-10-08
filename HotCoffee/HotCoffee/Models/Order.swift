//
//  Order.swift
//  HotCoffee
//
//  Created by MinKyeongTae on 2022/10/08.
//

// MARK:  19. Let's implement Creating Models!!

import Foundation

enum CoffeeType: String, Codable, CaseIterable {
  case cappuccino
  case latte
  case espressino
  case corado
}

enum CoffeeSize: String, Codable, CaseIterable {
  case small
  case medium
  case large
}

struct Order: Codable {
  let name: String
  let email: String
  let type: CoffeeType
  let size: CoffeeSize
}
