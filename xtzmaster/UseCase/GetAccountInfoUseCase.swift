import Foundation
import RxSwift

class GetAccountInfoUseCase {
  let accountProvider = AccountProvider()
  
  func getRootAccount(by address: String) -> Observable<Account> {
    return accountProvider
      .getAccount(address: address)
      .map {
        DataStore.shared.account = $0
        return $0
      }
  }
}
