import Foundation
import RxSwift

class GetBakingInfoUseCase {
  let accountProvider = AccountProvider()
  
  func getAllDelegators() -> Observable<[Delegator]> {
    return accountProvider.getAllDelegators()
  }
  
  func getRewardSplit(delegatorAddress: String) -> Observable<RewardSplit>{
    guard let account = DataStore.shared.account else {
      fatalError("Network Error")
    }
    
    return accountProvider.getRewardSplit(delegatorAddress: delegatorAddress, cycle: account.cycle - 6)
  }
}
