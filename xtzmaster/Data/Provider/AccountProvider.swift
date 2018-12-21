import Foundation
import Moya
import RxSwift

struct AccountProvider {
  func getAccount(address: String) -> Observable<Account> {
    return Observable.just(address)
      .flatMap { address in
        MoyaProvider<XTZMasterAPI>().rx.request(.getAccount(accountAddress: address))
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
        MoyaProvider<XTZMasterAPI>().rx.request(.getAccount(accountAddress: address))
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
  
  private func mapResponseTo<T>(response: Response) -> Observable<T> where T: Codable {
    do {
      let filteredResponse = try response.filterSuccessfulStatusCodes()
      return try Observable.just(JSONDecoder().decode(T.self, from: filteredResponse.data))
    } catch let error {
      return Observable.error(error)
    }
  }
}
