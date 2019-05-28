import UIKit
import RxSwift
import SafariServices

protocol BakingDetailViewCellDelegate {
  func cellTapped(with url: URL)
}

class BakingDetailViewController: UIViewController {
  
  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet weak var emptyView: UIView!

  var singleRowCellViewModels: [BakingDetailCellViewModel] = []
  var twoRowsCellViewModels: [BakingDetailCellViewModel] = []
  var delegator: Delegator?
  let viewModel = BakingDetailViewModel()
  let disposeBag = DisposeBag()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.navigationItem.title = R.string.localizable.bakingDetails()
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.help(), style: .plain, target: self, action: #selector(help))
  }

  @objc
  func help() {

  }
  
  override func viewDidLoad() {
    collectionView.delegate = self
    collectionView.dataSource = self

    collectionView.register(UINib(resource: R.nib.bakingDetailSingleRowCell), forCellWithReuseIdentifier: "bakingDetailSingleRowCell")

    collectionView.register(UINib(resource: R.nib.bakingDetailTwoRowsCell), forCellWithReuseIdentifier: "bakingDetailTwoRowsCell")

    if let delegator = self.delegator {
      self.showLoading()
      viewModel.createCellViewModels(with: delegator)
        .observeOn(MainScheduler.instance)
        .subscribe(
          onNext: { [unowned self] in
            self.singleRowCellViewModels = $0[.singleRow] ?? []
            self.twoRowsCellViewModels = $0[.twoRows] ?? []
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
    if section == 0 {
      return singleRowCellViewModels.count
    } else {
      return twoRowsCellViewModels.count
    }
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if indexPath.section == 0 {
      return CGSize(width: self.view.frame.width - 40, height: 40)
    } else {
      return CGSize(width: self.view.frame.width - 40, height: 85)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.section == 0 {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bakingDetailSingleRowCell", for: indexPath) as! BakingDetailSingleRowCellView
      cell.update(with: singleRowCellViewModels[indexPath.row])
      return cell
    } else {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bakingDetailTwoRowsCell", for: indexPath) as! BakingDetailTwoRowsCellView
      cell.update(with: twoRowsCellViewModels[indexPath.row])
      return cell
    }
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let viewModel: BakingDetailCellViewModel?
    if indexPath.section == 0 {
      let cell = collectionView.cellForItem(at: indexPath) as! BakingDetailSingleRowCellView
      viewModel = cell.viewModel
    } else {
      let cell = collectionView.cellForItem(at: indexPath) as! BakingDetailTwoRowsCellView
      viewModel = cell.viewModel
    }
    if let url = viewModel?.url {
      cellTapped(with: url)
    }
  }

  private func cellTapped(with url: URL) {
    let config = SFSafariViewController.Configuration()
    let vc = SFSafariViewController(url: url, configuration: config)
    present(vc, animated: true)
  }
}
