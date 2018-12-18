import Foundation
import UIKit

class SettingsViewController: UIViewController {
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.tabBarItem = UITabBarItem(title: "Settings", image: R.image.settings(), selectedImage: R.image.settingsSelected())
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
