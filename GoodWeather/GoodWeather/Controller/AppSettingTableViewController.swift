//
//  AppSettingTableViewController.swift
//  GoodWeather
//
//  Created by MinKyeongTae on 2022/10/17.
//

import UIKit

class AppSettingTableViewController: UITableViewController {
  
  private var settingsViewModel = SettingsViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.prefersLargeTitles = true
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
    return cell
  }
}
