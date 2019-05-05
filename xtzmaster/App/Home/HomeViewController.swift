import Foundation
import UIKit
import RxSwift

class HomeViewController: UIViewController {
  private var disposeBag: DisposeBag = DisposeBag()
  private let usecase = GetAccountInfoUseCase()
  private let rootAccount = "tz1KfEsrtDaA1sX7vdM4qmEPWuSytuqCDp5j"

  @IBOutlet weak var delegationButton: UIButton!

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.tabBarItem = UITabBarItem(title: "Home", image: R.image.home(), selectedImage: R.image.homeSelected())
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
    
    usecase.getRootAccount(by: rootAccount)
      .subscribe(onNext: { account in
        print(account)
      }, onError: { error in
        print(error)
      })
      .disposed(by: disposeBag)
  }
}
