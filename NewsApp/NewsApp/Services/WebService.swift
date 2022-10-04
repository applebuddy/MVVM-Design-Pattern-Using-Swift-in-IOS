//
//  WebService.swift
//  NewsApp
//
//  Created by MinKyeongTae on 2022/10/04.
//

import Foundation

class WebService {
  func getArticles(url: URL, completion: @escaping ([Any]?) -> ()) {
    URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        print(error.localizedDescription)
        completion(nil)
        return
      }
      
      if let data = data {
        print(data)
//        completion(data)
      }
    }
    .resume()
  }
}
