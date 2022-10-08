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
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  
  private var viewModel = AddCoffeeOrderViewModel()
  private var coffeeSizesSegmentedControl: UISegmentedControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  private func setupUI() {
    self.coffeeSizesSegmentedControl = UISegmentedControl(items: self.viewModel.sizes)
    self.coffeeSizesSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(coffeeSizesSegmentedControl)
    coffeeSizesSegmentedControl.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20).isActive = true
    coffeeSizesSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
  }
}

extension AddOrderViewController {
  @IBAction func save() {
    let name = self.nameTextField.text
    let email = self.emailTextField.text
    let selectedSize = self.coffeeSizesSegmentedControl.titleForSegment(at: self.coffeeSizesSegmentedControl.selectedSegmentIndex)
    
    guard let indexPath = tableView.indexPathForSelectedRow else {
      fatalError("Error in selecting coffee!!")
    }
    
    viewModel.name = name
    viewModel.email = email
    viewModel.selectedType = viewModel.types[indexPath.row]
    viewModel.selectedSize = selectedSize
  }
  
  @IBAction func close() {
    
  }
}

extension AddOrderViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
  }
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    tableView.cellForRow(at: indexPath)?.accessoryType = .none
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
