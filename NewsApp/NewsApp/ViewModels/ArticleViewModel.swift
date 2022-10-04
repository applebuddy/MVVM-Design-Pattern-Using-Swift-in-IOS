//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by MinKyeongTae on 2022/10/04.
//

import Foundation

struct ArticleListViewModel {
  private let articles: [Article]
  
  init(_ articles: [Article]) {
    self.articles = articles
  }
}

extension ArticleListViewModel {
  var numberOfSections: Int {
    return 1
  }
  
  func numberOfRowsInSection(_ section: Int) -> Int {
    return self.articles.count
  }
  
  func articleAtIndex(_ index: Int) -> ArticleViewModel {
    return ArticleViewModel(self.articles[index])
  }
}

struct ArticleViewModel {
  private let article: Article
}

extension ArticleViewModel {
  init(_ article: Article) {
    self.article = article
  }
}

extension ArticleViewModel {
  
  var title: String {
    return self.article.title
  }
  
  var description: String {
    return self.article.description
  }
}
