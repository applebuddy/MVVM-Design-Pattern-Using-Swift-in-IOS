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

extension Order {
  static var all: Resource<[Order]> = {
    guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
      fatalError("URL is incorrect!!")
    }
    
    return Resource<[Order]>(url: url)
  }()
  
  static func create(viewModel: AddCoffeeOrderViewModel) -> Resource<Order?> {
    let order = Order(viewModel)
    guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
      fatalError("URL is incorrect!!")
    }
    
    guard let data = try? JSONEncoder().encode(order) else {
      fatalError("Error encoding order!!")
    }
    
    var resource = Resource<Order?>(url: url)
    resource.httpMethod = .post
    resource.body = data
    return resource
  }
}

extension Order {
  init?(_ viewModel: AddCoffeeOrderViewModel) {
    guard let name = viewModel.name,
          let email = viewModel.email,
          let selectedType = CoffeeType(rawValue: viewModel.selectedType!.lowercased()),
          let selectedSize = CoffeeSize(rawValue: viewModel.selectedSize!.lowercased()) else {
      return nil
    }
    self.name = name
    self.email = email
    self.size = selectedSize
    self.type = selectedType
  }
}
