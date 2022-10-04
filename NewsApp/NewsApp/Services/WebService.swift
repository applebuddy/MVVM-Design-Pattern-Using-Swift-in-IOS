//
//  WebService.swift
//  NewsApp
//
//  Created by MinKyeongTae on 2022/10/04.
//

import Foundation

class WebService {
  func getArticles(url: URL, completion: @escaping ([Article]?) -> ()) {
    URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        print(error.localizedDescription)
        completion(nil)
        return
      }
      
      guard let data = data else {
        completion(nil)
        return
      }

      guard let articles = try? JSONDecoder().decode(ArticleList.self, from: data).articles else {
        completion(nil)
        return
      }

      print(articles)
      completion(articles)
    }
    .resume()
  }
}
