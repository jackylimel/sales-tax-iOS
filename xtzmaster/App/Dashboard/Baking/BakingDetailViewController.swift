import UIKit
import RxSwift

class BakingDetailViewController: UIViewController {
  
  @IBOutlet var collectionView: UICollectionView!
  
  var cellViewModels: [BakingDetailCellViewModel] = []
  var delegator: Delegator?
  let viewModel = BakingDetailViewModel()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.navigationItem.title = "Baking Detail"
  }
  
  override func viewDidLoad() {
    print(delegator)
  }
}
