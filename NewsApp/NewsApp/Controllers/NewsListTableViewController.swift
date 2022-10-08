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
import Combine

@MainActor
class NewsListTableViewController: UITableViewController {
  
  private var viewModel: ArticleListViewModel?
  private let disposeBag = DisposeBag()
  private var cancellables = Set<AnyCancellable>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    self.navigationController?.navigationBar.prefersLargeTitles = true
    // RxSwift 버전
    let apiKey = "332061f95205453e87c5c53efeef93f8"
    let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)")!
    
    // Combine framework를 통한 functional programming 구독 방식 viewModel 업데이트
    let resource = Resource<ArticleList>(url: url)
    URLSession.loadWithCombine(resource: resource)
      .sink(receiveValue: { [weak self] articleList in
        self?.viewModel = ArticleListViewModel(articleList.articles)
        self?.tableView.reloadData()
      }).store(in: &cancellables)
    
    // RxSwift, RxCocoa를 통한 구독방식 viewModel 업데이트
    /*
    let resource = Resource<ArticleList>(url: url)
    URLRequest.loadWithRx(resource: resource)
      .subscribe(onNext: { [weak self] articleList in
        self?.viewModel = ArticleListViewModel(articleList.articles)
        self?.tableView.reloadData()
      })
      .disposed(by: disposeBag)
     */
    
    // RxSwift 미사용, 일반 명령형 프로그래밍 시 API 요청 및 viewModel 업데이트
    /*
    WebService().getArticles(url: url) { [weak self] articles in
      guard let articles = articles else { return }
      DispatchQueue.main.async {
        self?.viewModel = ArticleListViewModel(articles)
        self?.tableView.reloadData()
      }
    }
     */
  }
}

extension NewsListTableViewController {
  override func numberOfSections(in tableView: UITableView) -> Int {
    return self.viewModel?.numberOfSections ?? 0
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel?.numberOfRowsInSection(section) ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
      return UITableViewCell()
    }
    
    let article = viewModel?.articles[indexPath.row]
    cell.titleLabel.text = article?.title
    cell.descriptionLabel.text = article?.description
    return cell
  }
}
