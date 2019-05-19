import UIKit

class DashboardDelegatorCell: UITableViewCell {
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var separator: UIView!

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    addressLabel?.numberOfLines = 0
    addressLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
    selectionStyle = .none
  }
  
  func setAddress(address: String) {
    addressLabel?.text = address
  }
}
