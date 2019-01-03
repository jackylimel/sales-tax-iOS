import Foundation
import UIKit
import RxSwift
import MBProgressHUD

class DashboardViewController: UIViewController {
  private var disposeBag: DisposeBag = DisposeBag()
  
  @IBOutlet weak var bakedAddressesTableView: UITableView!
  
  var bakedAddresses: [String] = []
  let dashboardViewModel = DashboardViewModel()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.tabBarItem = UITabBarItem(title: "Dashboard", image: R.image.dashboard(), selectedImage: R.image.dashboardSelected())
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    showLoading()
    
    dashboardViewModel.loadAddresses()
      .subscribe(onNext: { [weak self] addresses in
        self?.bakedAddresses.append(contentsOf: addresses)
        self?.hideLoading()
        self?.bakedAddressesTableView.reloadData()
      })
      .disposed(by: disposeBag)
    bakedAddressesTableView.dataSource = self
    bakedAddressesTableView.delegate = self
    bakedAddressesTableView.register(DashboardAddressCell.self, forCellReuseIdentifier: "DashboardAddressCell")
  }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return bakedAddresses.count
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
    let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardAddressCell", for: indexPath) as! DashboardAddressCell
    let address = bakedAddresses[indexPath.section]
    cell.backgroundColor = R.color.cell()
    cell.textLabel?.textColor = UIColor.white
    cell.textLabel?.text = address
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


