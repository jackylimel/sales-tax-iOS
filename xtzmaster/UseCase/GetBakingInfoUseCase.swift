import Foundation
import RxSwift

class GetBakingInfoUseCase {
  let accountProvider = AccountProvider()
  
  var currentCycle: Int = 0
  
  static let shared = GetBakingInfoUseCase()
  
  func getCurrentCycle() -> Observable<Int> {
    return accountProvider
      .getCurrentCycle()
      .do(onNext: { [weak self] value in
       self?.currentCycle = value
      })
  }
  
  func getAllBakedAddresses(by address: String) -> Observable<[String]> {
    return accountProvider.getAllBakedAddress(bakerAddress: address)
  }
}
