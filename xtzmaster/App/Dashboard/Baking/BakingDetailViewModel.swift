import RxSwift

class BakingDetailViewModel {
  private let disposeBag = DisposeBag()
  private(set) var account = PublishSubject<Account>()
  private let accountUseCase = GetAccountInfoUseCase()
  
  func getAccount(by address: String) {
//    accountUseCase
//      .getAccount(by: address)
//      .map { [weak self] in
//        self?.account.onNext($0)
//      }
//      .subscribe()
//      .disposed(by: disposeBag)
  }
  
  func createCellViewModels(with delegator: Delegator) -> [BakingDetailCellViewModel] {
    let currentBalance = BakingDetailCellViewModel(title: "Current Balance", value: String(delegator.balance))
    let rewardPaidOut = BakingDetailCellViewModel(title: "Reward Paid-out?", value: "Yes")
    let currentCycle = BakingDetailCellViewModel(title: "Current Cycle", value: "66")
    return [currentBalance, rewardPaidOut, currentCycle]
  }
}
