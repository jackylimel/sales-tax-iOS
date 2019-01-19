import RxSwift

class BakingDetailViewModel {
  private let bakingInfoUseCase = GetBakingInfoUseCase()
  private let accountUseCase = GetAccountInfoUseCase()
  
  func createCellViewModels(with delegator: Delegator) -> Observable<[BakingDetailCellViewModel]> {
    return bakingInfoUseCase
      .getRewardSplit(delegatorAddress: delegator.address)
      .map { rewardSplit -> [BakingDetailCellViewModel] in
        let currentBalance = BakingDetailCellViewModel(title: "Current Balance", value: String(delegator.balance))
        let rewardPaidOut = BakingDetailCellViewModel(title: "Reward Paid-out?", value: "Yes")
        let currentCycle = BakingDetailCellViewModel(title: "Current Cycle", value: String(rewardSplit.currentCycle))
        let daysToNextReward = BakingDetailCellViewModel(title: "To next reward", value: "2 days 7 hours")
        let daysWith = BakingDetailCellViewModel(title: "With XTZMaster", value: "140 days")
        let joinedCycle = BakingDetailCellViewModel(title: "Joined Cycle", value: delegator.joinedCycle)
        let feeRate = BakingDetailCellViewModel(title: "Fee rate", value: String(rewardSplit.feeRate))
        let unlockedCycle = BakingDetailCellViewModel(title: "Unlocked Cycle", value: String(rewardSplit.cycle))
        let balanceByUnlockedCycle = BakingDetailCellViewModel(title: "Balance By Cycle \(rewardSplit.cycle)", value: String(rewardSplit.balance))
        return [currentBalance, rewardPaidOut, currentCycle, daysToNextReward, daysWith, joinedCycle, feeRate, unlockedCycle, balanceByUnlockedCycle]
      }
  }
}
