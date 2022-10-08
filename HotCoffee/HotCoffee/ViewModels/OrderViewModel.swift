//
//  OrderViewModel.swift
//  HotCoffee
//
//  Created by MinKyeongTae on 2022/10/08.
//

// MARK: 21. Let's implement ViewModel!!

import Foundation

class OrderListViewModel {
  let ordersViewModel: [OrderViewModel]
  
  init() {
    self.ordersViewModel = [OrderViewModel]()
  }
}

extension OrderListViewModel {
  func orderViewModel(at index: Int) -> OrderViewModel {
    return ordersViewModel[index]
  }
}

struct OrderViewModel {
  let order: Order
}

extension OrderViewModel {
  var name: String {
    return order.name
  }
  
  var email: String {
    return order.email
  }
  
  var type: String {
    return self.order.type.rawValue.capitalized
  }
  
  var size: String {
    return self.order.size.rawValue.capitalized
  }
}
