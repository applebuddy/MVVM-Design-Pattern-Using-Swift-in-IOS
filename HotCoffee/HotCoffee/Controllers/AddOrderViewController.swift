//
//  AddOrderViewController.swift
//  HotCoffee
//
//  Created by MinKyeongTae on 2022/10/08.
//

import UIKit
import Combine
import RxSwift

protocol AddCoffeeOrderDelegate: AnyObject {
  func addCoffeeOrderViewControllerDidSave(order: Order, controller: UIViewController?)
  func addCoffeeOrderViewControllerDidClose(controller: UIViewController)
}

class AddOrderViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  
  private var viewModel = AddCoffeeOrderViewModel()
  private var coffeeSizesSegmentedControl: UISegmentedControl!
  private var cancellables = Set<AnyCancellable>()
  private let disposeBag = DisposeBag()
  weak var delegate: AddCoffeeOrderDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  private func setupUI() {
    self.coffeeSizesSegmentedControl = UISegmentedControl(items: self.viewModel.sizes)
    self.coffeeSizesSegmentedControl.selectedSegmentIndex = 0
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
    
    // Combine 활용, API 처리
    /*
    Webservice().loadWithCombine(resource: Order.create(viewModel: viewModel))
      .sink { [weak self] order in
        guard let order = order else { return }
        self?.delegate?.addCoffeeOrderViewControllerDidSave(order: order, controller: self)
      }
      .store(in: &cancellables)
    */
    
    // RxSwift, RxCocoa 활용, API 처리
    Webservice().loadWithRx(resource: Order.create(viewModel: viewModel))
      .subscribe(onNext: { [weak self] order in
        guard let order = order else { return }
        self?.delegate?.addCoffeeOrderViewControllerDidSave(order: order, controller: self)
      })
      .disposed(by: disposeBag)
    
    /*
    Webservice().load(resource: Order.create(viewModel: viewModel)) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let order):
        print(order)
        guard let order = order, let delegate = self.delegate else {
          return
        }
        DispatchQueue.main.async {
          self.delegate?.addCoffeeOrderViewControllerDidSave(order: order, controller: self)
        }
      case .failure(let error):
        print(error)
      }
    }
     */
  }
  
  @IBAction func close() {
    guard let delegate = self.delegate else {
      return
    }
    delegate.addCoffeeOrderViewControllerDidClose(controller: self)
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
