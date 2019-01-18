import Foundation
import UIKit
import RxSwift
import MBProgressHUD

class DashboardViewController: UIViewController {
  private var disposeBag: DisposeBag = DisposeBag()
  
  @IBOutlet weak var bakedAddressesTableView: UITableView!
  
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
      .subscribe(onNext: { [weak self] delegators in
        self?.delegators.append(contentsOf: delegators)
        self?.hideLoading()
        self?.bakedAddressesTableView.reloadData()
      })
      .disposed(by: disposeBag)
    bakedAddressesTableView.dataSource = self
    bakedAddressesTableView.delegate = self
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
    return 5
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
    cell.backgroundColor = R.color.grey()
    cell.textLabel?.textColor = R.color.cell()
    cell.textLabel?.text = delegator.address
    cell.textLabel?.numberOfLines = 0
    cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
    cell.textLabel?.sizeToFit()
    cell.selectionStyle = .none
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath)
    cell?.setSelected(false, animated: false)
  }
}


