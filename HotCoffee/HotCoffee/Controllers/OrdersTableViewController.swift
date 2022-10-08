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
  
  var orderListViewModel = OrderListViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    populateOrders()
  }
  
  private func populateOrders() {
    Webservice().load(resource: Order.all) { [weak self] result in
      switch result {
      case  .success(let orders):
        print(orders)
        self?.orderListViewModel.orders = orders.map(OrderViewModel.init)
        self?.tableView.reloadData()
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  // 델리게이션 패턴 적용
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let viewController = segue.destination as? AddOrderViewController else {
      fatalError("Error performing segue!")
    }
    // 커피 주문 save / close event를 감지하기위해 델리게이션 패턴 사용
    viewController.delegate = self
  }
}

extension OrdersTableViewController: AddCoffeeOrderDelegate {
  func addCoffeeOrderViewControllerDidSave(order: Order, controller: UIViewController?) {
    // 추가 단일 주문 받은 커피 데이터를 추가해서 테이블 뷰에 띄운다.
    controller?.dismiss(animated: true)
    let orderViewModel = OrderViewModel(order: order)
    orderListViewModel.orders.append(orderViewModel)
    tableView.insertRows(
      at: [IndexPath(
        row: orderListViewModel.orders.count - 1,
        section: 0)], with: .automatic
    )
  }
  
  func addCoffeeOrderViewControllerDidClose(controller: UIViewController) {
    controller.dismiss(animated: true)
  }
  
  
}

extension OrdersTableViewController {
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return orderListViewModel.orders.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let viewModel = self.orderListViewModel.orders[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath)
    cell.textLabel?.text = viewModel.type
    cell.detailTextLabel?.text = viewModel.size
    return cell
  }
}
