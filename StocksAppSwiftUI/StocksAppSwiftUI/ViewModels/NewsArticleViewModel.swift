//
//  NewsArticleViewModel.swift
//  StocksAppSwiftUI
//
//  Created by MinKyeongTae on 2022/10/10.
//

import Foundation

struct NewsArticleViewModel {
  let article: Article
  
  var imageURL: String {
    article.imageURL
  }
  
  var title: String {
    article.title
  }
  
  var publication: String {
    article.publication.uppercased()
  }
}
