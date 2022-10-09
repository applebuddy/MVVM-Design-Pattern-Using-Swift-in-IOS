//
//  Stock.swift
//  StocksAppSwiftUI
//
//  Created by MinKyeongTae on 2022/10/09.
//

import Foundation

struct Stock: Decodable {
  let symbol: String
  let description: String
  let price: Double
  let change: String
}
