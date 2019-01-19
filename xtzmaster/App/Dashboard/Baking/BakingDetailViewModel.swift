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
    let daysToNextReward = BakingDetailCellViewModel(title: "To next reward", value: "2 days 7 hours")
    let daysWith = BakingDetailCellViewModel(title: "With XTZMaster", value: "140 days")
    let joinedCycle = BakingDetailCellViewModel(title: "Joined Cycle", value: delegator.joinedCycle)
    let feeRate = BakingDetailCellViewModel(title: "Fee rate", value: "8.0%")
    let unlockedCycle = BakingDetailCellViewModel(title: "Unlocked Cycle", value: "60")
    let balanceByUnlockedCycle = BakingDetailCellViewModel(title: "Balance By Cycle 60", value: "327,123.78")
    return [currentBalance, rewardPaidOut, currentCycle, daysToNextReward, daysWith, joinedCycle, feeRate, unlockedCycle, balanceByUnlockedCycle]
  }
}
