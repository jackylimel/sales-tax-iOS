import Foundation
import RxSwift

class GetBakingInfoUseCase {
  let accountProvider = AccountProvider()
  
  func getAllBakedAddresses(by address: String) -> Observable<[String]> {
    return accountProvider.getAllBakedAddress(bakerAddress: address)
  }
}
