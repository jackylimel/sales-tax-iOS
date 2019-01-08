import UIKit

class SettingCell: UITableViewCell {
  
  @IBOutlet weak var icon: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var separator: UIView!
  
  override func layoutSubviews() {
    separator.backgroundColor = UIColor(red: 234, green: 234, blue: 234)
  }
  
  var model: SettingCellModel? {
    didSet {
      guard let newModel = model else { return }
      if let image = UIImage(named: newModel.imageName) {
        self.icon.image = image
      }
      self.titleLabel.text = newModel.title
    }
  }
}
