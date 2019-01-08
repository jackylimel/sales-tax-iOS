import Foundation
import UIKit

class SettingsViewController: UIViewController {
  @IBOutlet weak var settingsTableView: UITableView!
  
  var items:[[SettingCellModel]] = []
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.tabBarItem = UITabBarItem(title: "Settings", image: R.image.settings(), selectedImage: R.image.settingsSelected())
    self.navigationItem.title = "Settings"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    settingsTableView.delegate = self
    settingsTableView.dataSource = self
    
    setupData()
  }
  
  private func setupData() {
    items = [[SettingCellModel(imageName: "icon_twitter",
                      title: NSLocalizedString("Twitter", comment: ""),
                      url: Constants.twitterURL),
     SettingCellModel(imageName: "",
                      title: NSLocalizedString("Reddit", comment: ""),
                      url: Constants.redditUrl),
     SettingCellModel(imageName: "",
                      title: NSLocalizedString("Slack", comment: ""),
                      url: Constants.slackUrl)
     ]]
  }
}

extension SettingsViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.items.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.items[section].count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.settingCell, for: indexPath)!
    let model = items[indexPath.section][indexPath.row]
    cell.model = model
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }
}

extension SettingsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath)
    cell?.setSelected(false, animated: true)
    
   let model = items[indexPath.section][indexPath.row]
   guard let url = model.url else {
     return
   }
   self.showWebPage(url: url)
  }
}
