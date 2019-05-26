import Foundation
import UIKit
import RxSwift

class HomeViewController: UIViewController {
  private var disposeBag: DisposeBag = DisposeBag()
  private let usecase = GetAccountInfoUseCase()
  private let rootAccount = "tz1KfEsrtDaA1sX7vdM4qmEPWuSytuqCDp5j"

  @IBOutlet weak var delegationButton: UIButton!
  @IBOutlet weak var totalCapRow: SingleRow!
  @IBOutlet weak var userPercentRow: SingleRow!
  @IBOutlet weak var avaiableRollsRow: SingleRow!
  @IBOutlet weak var cycleRow: SingleRow!

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.tabBarItem = UITabBarItem(title: R.string.localizable.baking(), image: R.image.home(), selectedImage: R.image.homeSelected())
    self.navigationItem.title = "XTZMaster"
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == R.segue.homeViewController.showDelegationViewController.identifier,
      let controller = segue.destination as? DelegationViewController {
            controller.account = rootAccount
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    delegationButton.layer.cornerRadius = 5

    totalCapRow.titleLabel.text = R.string.localizable.totalCap()
    totalCapRow.valueLabel.text = ""

    userPercentRow.titleLabel.text = R.string.localizable.usedCap()
    userPercentRow.valueLabel.text = ""

    avaiableRollsRow.titleLabel.text = R.string.localizable.availableCap()
    avaiableRollsRow.valueLabel.text = ""

    cycleRow.titleLabel.text = R.string.localizable.cycle()
    cycleRow.valueLabel.text = ""
    
    usecase.getRootAccount(by: rootAccount)
      .subscribe(onNext: { [weak self] account in
        self?.updateUI(with: account)
      }, onError: { error in
        print(error)
      })
      .disposed(by: disposeBag)
  }

  func updateUI(with account: Account) {
    totalCapRow.valueLabel.text = "\(account.totalCap)"
    userPercentRow.valueLabel.text = "\(account.usedCapPercent) %"
    avaiableRollsRow.valueLabel.text = "\(account.availableCap) Rolls"
    cycleRow.valueLabel.text = "\(account.cycle)"
  }
}
