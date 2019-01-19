import UIKit
import RxSwift

class BakingDetailViewController: UIViewController {
  
  @IBOutlet var collectionView: UICollectionView!
  
  var cellViewModels: [BakingDetailCellViewModel] = []
  var delegator: Delegator?
  let viewModel = BakingDetailViewModel()
  let disposeBag = DisposeBag()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.navigationItem.title = "Baking Detail"
  }
  
  override func viewDidLoad() {
    collectionView.delegate = self
    collectionView.dataSource = self
    
    if let delegator = self.delegator {
      self.showLoading()
      viewModel.createCellViewModels(with: delegator)
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { [unowned self] in
          self.cellViewModels = $0
          self.hideLoading()
          self.collectionView.reloadData()
        })
        .disposed(by: disposeBag)
    }
  }
}

extension BakingDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cellViewModels.count
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.view.frame.width - 40, height: 100)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.bakingDetailCellView, for: indexPath)! as BakingDetailCellView
    cell.update(with: cellViewModels[indexPath.row])
    return cell
  }
}
