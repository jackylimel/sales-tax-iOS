import UIKit

class DashboardDelegatorCell: UITableViewCell {
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    backgroundColor = R.color.grey()
    textLabel?.textColor = R.color.cell()
    textLabel?.numberOfLines = 0
    textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
    selectionStyle = .none
  }
  
  func setAddress(address: String) {
    textLabel?.text = address
    textLabel?.sizeToFit()
  }
}
