import RxSwift

class BakingDetailViewModel {
  private let bakingInfoUseCase = GetBakingInfoUseCase()
  private let accountUseCase = GetAccountInfoUseCase()
  
  func createCellViewModels(with delegator: Delegator) -> Observable<[BakingDetailCellViewModel]> {
    return bakingInfoUseCase
      .getRewardSplit(delegatorAddress: delegator.address)
      .map { rewardSplit -> [BakingDetailCellViewModel] in
        let currentBalance = BakingDetailCellViewModel(title: "Current Balance", value: String(delegator.balance))
        let currentCycle = BakingDetailCellViewModel(title: "Current Cycle", value: String(DataStore.shared.account?.cycle ?? 0))
        let daysToNextReward = BakingDetailCellViewModel(title: "To next reward", value: DataStore.shared.account?.getTimeToNextReward() ?? "0 days 0 hours")
        let daysWith = BakingDetailCellViewModel(title: "With XTZMaster", value: delegator.daysWithXTZMaster())
        let joinedCycle = BakingDetailCellViewModel(title: "Joined Cycle", value: String(delegator.joinedCycle))
        let feeRate = BakingDetailCellViewModel(title: "Fee rate", value: rewardSplit.feeRate)
        let unlockedCycle = BakingDetailCellViewModel(title: "Unlocked Cycle", value: String(rewardSplit.cycle))
        let balanceByUnlockedCycle = BakingDetailCellViewModel(title: "Balance By Cycle \(rewardSplit.cycle)", value: String(rewardSplit.balance))
        let delegationAccount = BakingDetailCellViewModel(title: "Delegation Account", value: delegator.address)
        let managerAccount = BakingDetailCellViewModel(title: "Manager Account", value: delegator.manager)
        var result = [currentBalance, currentCycle, daysToNextReward, daysWith, joinedCycle, feeRate, unlockedCycle, balanceByUnlockedCycle, delegationAccount, managerAccount]
        if (rewardSplit.paid) {
          result.append(BakingDetailCellViewModel(title: "Reward paid", value: "https://tzscan.io/\(rewardSplit.paidReference)"))
        }
        return result
      }
  }
}
