import UIKit
import MBProgressHUD

extension UIViewController {
  func showLoading() {
    hideLoading()
    
    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
    hud.mode = .indeterminate
    hud.removeFromSuperViewOnHide = true
    hud.tag = 1001
  }
  
  func hideLoading() {
    if let hud = self.view.viewWithTag(1001) as? MBProgressHUD {
      hud.hide(animated: true)
    }
  }
  
  func showTipMessage(message: String) {
    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
    hud.mode = .text
    hud.label.numberOfLines = 0
    hud.label.text = message
    hud.hide(animated: true, afterDelay: 1)
  }
}
