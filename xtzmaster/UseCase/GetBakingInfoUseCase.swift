import Foundation
import RxSwift

class GetBakingInfoUseCase {
  let accountProvider = AccountProvider()
  
  static let shared = GetBakingInfoUseCase()
  
  func getAllDelegators() -> Observable<[Delegator]> {
    return accountProvider.getAllDelegators()
  }
}
