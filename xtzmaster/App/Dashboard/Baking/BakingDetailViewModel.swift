import RxSwift

class BakingDetailViewModel {
  private let bakingInfoUseCase = GetBakingInfoUseCase()
  private let accountUseCase = GetAccountInfoUseCase()
  
  func createCellViewModels(with delegator: Delegator) -> Observable<[BakingDetailCellType: [BakingDetailCellViewModel]]> {
    return bakingInfoUseCase
      .getRewardSplit(delegatorAddress: delegator.address)
      .map { rewardSplit -> [BakingDetailCellType: [BakingDetailCellViewModel]] in
        let currentBalance = BakingDetailCellViewModel(title: "Current Balance", value: String(delegator.balance), url: nil)
        let currentCycle = BakingDetailCellViewModel(title: "Current Cycle", value: String(DataStore.shared.account?.cycle ?? 0), url: nil)
        let daysToNextReward = BakingDetailCellViewModel(title: "To Next Reward", value: DataStore.shared.account?.getTimeToNextReward() ?? "0 days 0 hours", url: nil)
        let daysWith = BakingDetailCellViewModel(title: "With XTZMaster", value: delegator.daysWithXTZMaster(), url: nil)
        let joinedCycle = BakingDetailCellViewModel(title: "Joined Cycle", value: String(delegator.joinedCycle), url: nil)
        let feeRate = BakingDetailCellViewModel(title: "Fee Rate", value: rewardSplit.feeRate, url: nil)
        let unlockedCycle = BakingDetailCellViewModel(title: "Unlocked Cycle", value: String(rewardSplit.cycle), url: nil)
        let balanceByUnlockedCycle = BakingDetailCellViewModel(title: "Balance By Cycle \(rewardSplit.cycle)", value: String(rewardSplit.balance), url: nil)
        var singleRowViewModels = [currentBalance, currentCycle, daysToNextReward, daysWith, joinedCycle, feeRate, unlockedCycle, balanceByUnlockedCycle]
        if (rewardSplit.paid) {
          singleRowViewModels.append(BakingDetailCellViewModel(title: "Reward paid", value: "verify", url: URL(string: "https://tzscan.io/\(rewardSplit.paidReference)")))
        }

        let delegationAccount = BakingDetailCellViewModel(title: "Delegation Account", value: delegator.address, url: URL(string: "https://tzscan.io/\(delegator.address)"))
        let managerAccount = BakingDetailCellViewModel(title: "Manager Account", value: delegator.manager, url: URL(string: "https://tzscan.io/\(delegator.manager)"))
        let twoRowsViewModels = [delegationAccount, managerAccount]
        return [.singleRow: singleRowViewModels, .twoRows: twoRowsViewModels]
      }
  }
}
