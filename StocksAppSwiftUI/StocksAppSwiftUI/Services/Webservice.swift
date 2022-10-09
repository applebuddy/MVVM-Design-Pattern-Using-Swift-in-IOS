//
//  Webservice.swift
//  StocksAppSwiftUI
//
//  Created by MinKyeongTae on 2022/10/09.
//

// MARK: 58. Implementing the Webervice and Stocks Model
// MARK: NOTE:
// Stocks Web API has been updated. Please use the following URLs in your app.
// -> https://island-bramble.glitch.me/stocks
// -> https://island-bramble.glitch.me/top-news


import Foundation

enum AppError: Error {
  case noData
  case decodingFailed
}

class Webservice {
  
  func getTopNews(completion: @escaping (([Article]?) -> Void)) {
    guard let url = URL(string: "https://island-bramble.glitch.me/stocks") else {
      fatalError("URL is not correct")
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data, error == nil else {
        DispatchQueue.main.async {
          completion(nil)
        }
        return
      }
      
      let articles = try? JSONDecoder().decode([Article].self, from: data)
      DispatchQueue.main.async {
        completion(articles)
      }
    }.resume()
  }
  
  func getStocksWithAsyncAwait() async throws -> [Stock]? {
    guard let url = URL(string: "https://island-bramble.glitch.me/stocks") else {
      fatalError("URL is not correct")
    }
    guard let tupleData = try? await URLSession.shared.data(from: url) else {
      throw AppError.noData
    }

    guard let jsonData = try? JSONDecoder().decode([Stock].self, from: tupleData.0) else {
      throw AppError.decodingFailed
    }
    
    return jsonData
  }
  
  func getStocks(completion: @escaping (([Stock]?) -> Void)) {
    guard let url = URL(string: "https://island-bramble.glitch.me/stocks") else {
      fatalError("URL is not correct")
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data, error == nil else {
        DispatchQueue.main.async {
          completion(nil)
        }
        return
      }
      guard let stocks = try? JSONDecoder().decode([Stock].self, from: data) else {
        DispatchQueue.main.async {
          completion(nil)
        }
        return
      }
      DispatchQueue.main.async {
        completion(stocks)
      }
    }
    .resume()
  }
}
