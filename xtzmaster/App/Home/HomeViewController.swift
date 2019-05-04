import Foundation
import UIKit
import RxSwift

class HomeViewController: UIViewController {
  private var disposeBag: DisposeBag = DisposeBag()
  let usecase = GetAccountInfoUseCase()
  
  @IBOutlet weak var delegationButton: UIButton!

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.tabBarItem = UITabBarItem(title: "Home", image: R.image.home(), selectedImage: R.image.homeSelected())
    self.navigationItem.title = "XTZMaster"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    delegationButton.layer.cornerRadius = 5
    
    usecase.getRootAccount(by: "tz1KfEsrtDaA1sX7vdM4qmEPWuSytuqCDp5j")
      .subscribe(onNext: { account in
        print(account)
      }, onError: { error in
        print(error)
      })
      .disposed(by: disposeBag)
  }
}
