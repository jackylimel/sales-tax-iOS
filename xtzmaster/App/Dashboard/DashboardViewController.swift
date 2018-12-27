import Foundation
import UIKit
import RxSwift

class DashboardViewController: UIViewController {
  private var disposeBag: DisposeBag = DisposeBag()
  let usecase = GetBakingInfoUseCase()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.tabBarItem = UITabBarItem(title: "Dashboard", image: R.image.dashboard(), selectedImage: R.image.dashboardSelected())
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    usecase.getAllBakedAddresses(by: "tz1KfEsrtDaA1sX7vdM4qmEPWuSytuqCDp5j")
      .subscribe(onNext: { account in
        print(account)
      }, onError: { error in
        print(error)
      })
      .disposed(by: disposeBag)
  }
}
