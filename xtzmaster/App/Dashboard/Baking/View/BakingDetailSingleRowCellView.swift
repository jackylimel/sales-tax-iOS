import UIKit
import SafariServices

class BakingDetailSingleRowCellView: UICollectionViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var valueLabel: UILabel!

  var viewModel: BakingDetailCellViewModel?

  func update(with viewModel: BakingDetailCellViewModel) {
    titleLabel.text = viewModel.title
    valueLabel.text = viewModel.value
    self.viewModel = viewModel
  }
}
