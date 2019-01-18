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
    collectionView.delegate = self
    collectionView.dataSource = self
    
    if let delegator = self.delegator {
      cellViewModels = viewModel.createCellViewModels(with: delegator)
      collectionView.reloadData()
    }
  }
}

extension BakingDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cellViewModels.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.bakingDetailCellView, for: indexPath)! as BakingDetailCellView
    cell.update(with: cellViewModels[indexPath.row])
    return cell
  }
}
