import Foundation
import RxSwift

class GetAccountInfoUseCase {
  let accountProvider = AccountProvider()
  
  func getAccount(by address: String) -> Observable<Account> {
    let accountObservable = accountProvider.getAccount(address: address)
    let stakingObservable = accountProvider.getStaking(address: address)
    
    return Observable
      .zip(accountObservable, stakingObservable) {
        var temp = $0
        temp.staking = $1
        return temp
      }
  }
}
