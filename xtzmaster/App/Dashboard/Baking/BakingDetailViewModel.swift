import RxSwift

class BakingDetailViewModel {
  private let bakingInfoUseCase = GetBakingInfoUseCase()
  private let accountUseCase = GetAccountInfoUseCase()
  
  func createCellViewModels(with delegator: Delegator) -> Observable<[BakingDetailCellType: [BakingDetailCellViewModel]]> {
    return bakingInfoUseCase
      .getRewardSplit(delegatorAddress: delegator.address)
      .map { rewardSplit -> [BakingDetailCellType: [BakingDetailCellViewModel]] in
        let currentBalance = BakingDetailCellViewModel(title: R.string.localizable.currentBalance(), value: String(delegator.balance), url: nil)
        let currentCycle = BakingDetailCellViewModel(title: R.string.localizable.currentCycle(), value: String(DataStore.shared.account?.cycle ?? 0), url: nil)
        let daysToNextReward = BakingDetailCellViewModel(title: R.string.localizable.toNextReward(), value: DataStore.shared.account?.getTimeToNextReward() ?? "0 days 0 hours", url: nil)
        let daysWith = BakingDetailCellViewModel(title: R.string.localizable.withXTZMaster(), value: delegator.daysWithXTZMaster(), url: nil)
        let joinedCycle = BakingDetailCellViewModel(title: R.string.localizable.joinedCycle(), value: String(delegator.joinedCycle), url: nil)
        let reward = BakingDetailCellViewModel(title: R.string.localizable.reward(), value: rewardSplit.rewards, url: nil)
        let feeRate = BakingDetailCellViewModel(title: R.string.localizable.feeRate(), value: rewardSplit.feeRatePercent, url: nil)
        let unlockedCycle = BakingDetailCellViewModel(title: R.string.localizable.unlockedCycle(), value: String(rewardSplit.cycle), url: nil)
        let balanceByUnlockedCycle = BakingDetailCellViewModel(title: R.string.localizable.balanceByCycle(rewardSplit.cycle), value: String(rewardSplit.balance), url: nil)
        var singleRowViewModels = [currentBalance, currentCycle, daysToNextReward, daysWith, joinedCycle, reward, feeRate, unlockedCycle, balanceByUnlockedCycle]
        if (rewardSplit.paid) {
          singleRowViewModels.append(BakingDetailCellViewModel(title: R.string.localizable.rewardPaid(), value: R.string.localizable.verify(), url: URL(string: "https://tzscan.io/\(rewardSplit.paidReference)")))
        }

        let delegationAccount = BakingDetailCellViewModel(title: R.string.localizable.delegationAccount(), value: delegator.address, url: URL(string: "https://tzscan.io/\(delegator.address)"))
        let managerAccount = BakingDetailCellViewModel(title: R.string.localizable.managerAccount(), value: delegator.manager, url: URL(string: "https://tzscan.io/\(delegator.manager)"))
        let twoRowsViewModels = [delegationAccount, managerAccount]
        return [.singleRow: singleRowViewModels, .twoRows: twoRowsViewModels]
      }
  }
}
