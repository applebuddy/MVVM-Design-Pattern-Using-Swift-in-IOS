//
//  OrdersTableViewController.swift
//  HotCoffee
//
//  Created by MinKyeongTae on 2022/10/08.
//

// MARK: 20. Testing Webservice Client
// 1) Postman으로 아래와 같은 JSON 데이터를 전송 한 후, 앱에서 Get API를 호출하면
/*
 {
   "name": "John Doe",
   "email": "johndoe@gmail.com",
   "type": "latte",
   "size": "medium"
 }
 */
// 아래와 같은 데이터를 받을 수 있습니다. (로그 출력으로 확인)
// [HotCoffee.Order(name: "John Doe", email: "johndoe@gmail.com", type: HotCoffee.CoffeeType.latte, size: HotCoffee.CoffeeSize.medium)]


import Foundation
import UIKit

class OrdersTableViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    populateOrders()
  }
  
  private func populateOrders() {
    guard let coffeeOrdersURL = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
      fatalError("URL was incorrect")
    }
    
    let resource = Resource<[Order]>(url: coffeeOrdersURL)
    
    Webservice().load(resource: resource) { result in
      switch result {
      case  .success(let data):
        print(data)
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
}
