//
//  AddOrderViewController.swift
//  HotCoffee
//
//  Created by MinKyeongTae on 2022/10/08.
//

import Foundation
import UIKit

class AddOrderViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  private var viewModel = AddCoffeeOrderViewModel()
}

extension AddOrderViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.types.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeTypeTableViewCell", for: indexPath)
    cell.textLabel?.text = self.viewModel.types[indexPath.row]
    return cell
  }
}
