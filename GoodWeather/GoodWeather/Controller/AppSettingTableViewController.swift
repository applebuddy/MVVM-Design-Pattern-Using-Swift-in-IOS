//
//  AppSettingTableViewController.swift
//  GoodWeather
//
//  Created by MinKyeongTae on 2022/10/17.
//

import UIKit

protocol SettingsDelegate {
  func settingsDone(viewModel: SettingsViewModel)
}

class AppSettingTableViewController: UITableViewController {
  
  private var settingsViewModel = SettingsViewModel()
  var delegate: SettingsDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // uncheck all cells
    // 먼저 모든 셀의 accessory를 .none으로 설정
    tableView.visibleCells.forEach { cell in
      cell.accessoryType = .none
    }
    
    if let cell = tableView.cellForRow(at: indexPath) {
      // 선택된 셀의 accessoryType만 .checkmark 타입으로 설정
      cell.accessoryType = .checkmark
      let unit = Unit.allCases[indexPath.row]
      settingsViewModel.selectedUnit = unit
    }
  }
  
  override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) {
      cell.accessoryType = .none
    }
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return settingsViewModel.units.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let settingsItem = settingsViewModel.units[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "SettiingsCell", for: indexPath)
    cell.textLabel?.text = settingsItem.displayName
    
    // 선택된 unit이 있는 곳은 accessoryType을 .checkmark로 설정한다.
    if settingsItem == settingsViewModel.selectedUnit {
      cell.accessoryType = .checkmark
    }
    return cell
  }
  
  // MARK: - Action
  
  @IBAction func done() {
    delegate?.settingsDone(viewModel: self.settingsViewModel)
    dismiss(animated: true)
  }
}
