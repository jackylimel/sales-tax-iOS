import Foundation
import UIKit
import RxSwift
import MBProgressHUD

class DashboardViewController: UIViewController {
  private var disposeBag: DisposeBag = DisposeBag()
  private let searchController = UISearchController(searchResultsController: nil)

  @IBOutlet weak var delegatorsTableView: UITableView!
  
  var delegators: [Delegator] = []
  var filteredDelegators: [Delegator] = []
  let dashboardViewModel = DashboardViewModel()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.tabBarItem = UITabBarItem(title: "Dashboard", image: R.image.dashboard(), selectedImage: R.image.dashboardSelected())
    self.navigationItem.title = "Dashboard"
  }

  // This is to fix the problem that search bar is not visible on launch
  // https://stackoverflow.com/questions/46239883/show-search-bar-in-navigation-bar-without-scrolling-on-ios-11
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationItem.hidesSearchBarWhenScrolling = false
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    navigationItem.hidesSearchBarWhenScrolling = true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    showLoading()

    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search Address"
    navigationItem.searchController = searchController
    definesPresentationContext = true

    setupBinding()
  }

  private func setupBinding() {
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

    fileprivate func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

    private func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    fileprivate func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredDelegators = delegators.filter({( delegator: Delegator) -> Bool in
            return delegator.address.lowercased().contains(searchText.lowercased())
        })

        delegatorsTableView.reloadData()
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

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isFiltering() {
      return filteredDelegators.count
    }
    return delegators.count
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.dashboardDelegatorCell, for: indexPath)!
    let delegator: Delegator
    if isFiltering() {
        delegator = filteredDelegators[indexPath.row]
    } else {
        delegator = delegators[indexPath.row]
    }
    cell.setAddress(address: delegator.displayAddress)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: R.segue.dashboardViewController.showBakingDetail, sender: indexPath)
  }
}

extension DashboardViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    filterContentForSearchText(searchController.searchBar.text!)
  }
}
