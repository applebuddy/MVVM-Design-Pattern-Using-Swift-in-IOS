//
//  StockViewModel.swift
//  StocksAppSwiftUI
//
//  Created by MinKyeongTae on 2022/10/09.
//

import Foundation

struct StockViewModel {
  let stock: Stock
  
  var symbol: String {
    return stock.symbol
  }
  
  var description: String {
    return stock.description
  }
  
  var price: String {
    return String(format: "%.2f", self.stock.price)
  }
  
  var change: String {
    return stock.change
  }
}
