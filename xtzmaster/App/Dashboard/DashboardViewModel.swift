import RxSwift

class DashboardViewModel {
  let accountProvider = AccountProvider()
  
  func getAllDelegators() -> Observable<[Delegator]> {
    return accountProvider.getAllDelegators()
  }
}
