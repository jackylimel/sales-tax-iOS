import UIKit
import RxSwift

class BakingDetailViewController: UIViewController {
  
  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet weak var emptyView: UIView!

  var cellViewModels: [BakingDetailCellViewModel] = []
  var delegator: Delegator?
  let viewModel = BakingDetailViewModel()
  let disposeBag = DisposeBag()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.navigationItem.title = "Baking Details"
  }
  
  override func viewDidLoad() {
    collectionView.delegate = self
    collectionView.dataSource = self

    collectionView.register(UINib(resource: R.nib.bakingDetailSingleRowCell), forCellWithReuseIdentifier: "bakingDetailSingleRowCell")

    if let delegator = self.delegator {
      self.showLoading()
      viewModel.createCellViewModels(with: delegator)
        .observeOn(MainScheduler.instance)
        .subscribe(
          onNext: { [unowned self] in
            self.cellViewModels = $0
            self.hideLoading()
            self.collectionView.reloadData()
          }, onError: { [unowned self] error in
            self.hideLoading()
            self.collectionView.isHidden = true
            self.emptyView.isHidden = false
          }
        )
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
    return CGSize(width: self.view.frame.width - 40, height: 40)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bakingDetailSingleRowCell", for: indexPath) as! BakingDetailSingleRowCellView
    cell.update(with: cellViewModels[indexPath.row])
    return cell
  }
}
