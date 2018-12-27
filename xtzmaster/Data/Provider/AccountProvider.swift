import Foundation
import Moya
import RxSwift

struct AccountProvider {
  let provider = MoyaProvider<XTZMasterAPI>()
  
  func getAccount(address: String) -> Observable<Account> {
    return Observable.just(address)
      .flatMap { address in
        self.provider.rx.request(.getAccount(accountAddress: address))
      }
      .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
      .flatMap { (response) -> Observable<Account> in
        return self.mapResponseTo(response: response)
      }
      .catchError({ (error) in
        return Observable.error(error)
      })
  }
  
  func getStaking(address: String) -> Observable<String> {
    return Observable.just(address)
      .flatMap { address in
        self.provider.rx.request(.getStakingBalance(accountAddress: address))
      }
      .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
      .flatMap { (response) -> Observable<String> in
        if let json = try response.mapJSON() as? [String] {
          return Observable.just(json.first!)
        }
        return Observable.just("0")
      }
      .catchError({ (error) in
        return Observable.error(error)
      })
  }
  
  func getAllBakedAddress(bakerAddress: String) -> Observable<[String]> {
    return Observable.just(bakerAddress)
      .flatMap { address in
        self.provider.rx.request(.getAllBakedAddresses(bakerAddress: address))
      }
      .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
      .flatMap { (response) -> Observable<[String]> in
        if let json = try response.mapJSON() as? [String] {
          return Observable.just(json)
        }
        return Observable.just([])
      }
      .catchError({ (error) in
        return Observable.error(error)
      })
  }
  
  func getCurrentCycle() -> Observable<Int> {
    return Observable.just(true)
      .flatMap { _ in
        MoyaProvider<XTZMasterAPI>().rx.request(.getHead())
      }
      .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
      .flatMap { (response) -> Observable<Int> in
        if let json = try response.mapJSON() as? [String: Any],
           let level = json["level"] as? Int {
          return Observable.just(level / 4096)
        }
        return Observable.just(0)
      }
      .catchError({ (error) in
        return Observable.error(error)
      })
  }
  
  private func mapResponseTo<T>(response: Response) -> Observable<T> where T: Codable {
    do {
      let filteredResponse = try response.filterSuccessfulStatusCodes()
      return try Observable.just(JSONDecoder().decode(T.self, from: filteredResponse.data))
    } catch let error {
      return Observable.error(error)
    }
  }
}
