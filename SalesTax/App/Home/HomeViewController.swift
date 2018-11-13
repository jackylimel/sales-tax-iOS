import Foundation
import UIKit

class HomeViewController: UIViewController {
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.tabBarItem = UITabBarItem(title: "Home", image: R.image.home(), selectedImage: R.image.homeSelected())
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
