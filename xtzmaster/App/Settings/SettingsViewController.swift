import Foundation
import UIKit

class SettingsViewController: UIViewController {
  @IBOutlet weak var settingsTableView: UITableView!
  
  var items:[[SettingCellModel]] = []
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.tabBarItem = UITabBarItem(title: R.string.localizable.settings(), image: R.image.settings(), selectedImage: R.image.settingsSelected())
    self.navigationItem.title = R.string.localizable.settings()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    settingsTableView.delegate = self
    settingsTableView.dataSource = self
    
    setupData()
  }
  
  private func setupData() {
    items = [[SettingCellModel(imageName: "icon-twitter",
                      title: NSLocalizedString("Twitter", comment: ""),
                      url: Constants.twitterURL),
     SettingCellModel(imageName: "icon-reddit",
                      title: NSLocalizedString("Reddit", comment: ""),
                      url: Constants.redditUrl),
     SettingCellModel(imageName: "icon-slack",
                      title: NSLocalizedString("Slack", comment: ""),
                      url: Constants.slackUrl)
     ], [
      SettingCellModel(imageName: "icon-email",
                       title: R.string.localizable.email(),
                       url: Constants.mailUrl,
                       action: SettingCellAction.mail)
     ], [
      SettingCellModel(imageName: "icon-info",
                       title: R.string.localizable.faQ(),
                       url: Constants.faqUrl)
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
   self.executeAction(url: model.url, action: model.action)
  }
  
  private func executeAction(url: URL, action: SettingCellAction) {
    switch action {
    case .webpage:
      self.showWebPage(url: url)
    case .mail:
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
  }
}
