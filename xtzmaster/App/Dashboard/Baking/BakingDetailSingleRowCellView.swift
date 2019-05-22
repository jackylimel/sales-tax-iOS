import UIKit

class BakingDetailSingleRowCellView: UICollectionViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var valueLabel: UILabel!
  @IBOutlet weak var helpImage: UIImageView!

  func update(with viewModel: BakingDetailCellViewModel) {
    titleLabel.text = viewModel.title
    valueLabel.text = viewModel.value
  }
}
