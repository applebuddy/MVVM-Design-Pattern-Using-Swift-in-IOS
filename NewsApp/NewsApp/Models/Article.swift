//
//  Article.swift
//  NewsApp
//
//  Created by MinKyeongTae on 2022/10/04.
//

import Foundation

struct ArticleList: Decodable {
  let articles: [Article]
}

struct Article: Decodable {
  let title: String
  let description: String
}
