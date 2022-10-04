//
//  NewsListTableViewController.swift
//  NewsApp
//
//  Created by MinKyeongTae on 2022/10/04.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class NewsListTableViewController: UITableViewController {
  
  private var viewModel: ArticleListViewModel?
  private let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    self.navigationController?.navigationBar.prefersLargeTitles = true
    // RxSwift 버전
    let apiKey = "332061f95205453e87c5c53efeef93f8"
    let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)")!
    let resource = Resource<ArticleList>(url: url)
    URLRequest.load(resource: resource)
      .subscribe(onNext: { [weak self] articleList in
        self?.viewModel = ArticleListViewModel(articleList.articles)
        self?.tableView.reloadData()
      })
      .disposed(by: disposeBag)
    
    // RxSwift 미사용 시 API 요청 방법
    /*
    WebService().getArticles(url: url) { _ in
      //
    }
     */
  }
}
