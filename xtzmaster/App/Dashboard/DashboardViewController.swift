import Foundation
import UIKit

class DashboardViewController: UIViewController {
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.tabBarItem = UITabBarItem(title: "Dashboard", image: R.image.dashboard(), selectedImage: R.image.dashboardSelected())
  }
}
