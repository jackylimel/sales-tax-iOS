import UIKit

class BakingDetailTwoRowsCellView: UICollectionViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var valueLabel: UILabel!

  func update(with viewModel: BakingDetailCellViewModel) {
    titleLabel.text = viewModel.title
    valueLabel.text = viewModel.value
  }
}
