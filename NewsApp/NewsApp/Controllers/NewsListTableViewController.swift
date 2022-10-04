//
//  NewsListTableViewController.swift
//  NewsApp
//
//  Created by MinKyeongTae on 2022/10/04.
//

import Foundation
import UIKit

class NewsListTableViewController: UITableViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    self.navigationController?.navigationBar.prefersLargeTitles = true
    let apiKey = "332061f95205453e87c5c53efeef93f8"
    let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)")!
    WebService().getArticles(url: url) { _ in
      //
    }
  }
}
