import Foundation
import UIKit
import RxSwift
import MBProgressHUD

class DashboardViewController: UIViewController {
  private var disposeBag: DisposeBag = DisposeBag()
  
  @IBOutlet weak var delegatorsTableView: UITableView!
  
  var delegators: [Delegator] = []
  let dashboardViewModel = DashboardViewModel()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.tabBarItem = UITabBarItem(title: "Dashboard", image: R.image.dashboard(), selectedImage: R.image.dashboardSelected())
    self.navigationItem.title = "Dashboard"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    showLoading()
    
    dashboardViewModel.getAllDelegators()
      .subscribe(
        onNext: { [weak self] delegators in
          self?.delegators.append(contentsOf: delegators)
          self?.hideLoading()
          self?.delegatorsTableView.reloadData()
        },
        onError: { [weak self] error in
          self?.hideLoading()
          self?.showTipMessage(message: error.localizedDescription)
        }
      )
      .disposed(by: disposeBag)
    delegatorsTableView.dataSource = self
    delegatorsTableView.delegate = self
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == R.segue.dashboardViewController.showBakingDetail.identifier {
      if let viewController = segue.destination as? BakingDetailViewController,
         let indexPath = sender as? IndexPath {
        viewController.delegator = delegators[indexPath.section]
      }
    }
  }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return delegators.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 10
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView()
    headerView.backgroundColor = UIColor.clear
    return headerView
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.dashboardDelegatorCell, for: indexPath)!
    let delegator = delegators[indexPath.section]
    cell.setAddress(address: delegator.address)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: R.segue.dashboardViewController.showBakingDetail, sender: indexPath)
  }
}


