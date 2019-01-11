import Foundation
import Moya
import RxSwift

struct AccountProvider {
  let provider = MoyaProvider<XTZMasterAPI>()
  
  func getAccount(address: String) -> Observable<Account> {
    let request = provider.rx.request(.getAccount(accountAddress: address))
    let mapping = { response -> Observable<Account> in
      self.mapResponseTo(response: response)
    }
    return executeRequest(request: request, mapping: mapping)
  }
  
  func getStaking(address: String) -> Observable<String> {
    let request = provider.rx.request(.getStakingBalance(accountAddress: address))
    let mapping = { (response: Response) -> Observable<String> in
      do {
        if let json = try response.mapJSON() as? [String] {
          return Observable.just(json.first ?? "0")
        }
        return Observable.just("0")
      } catch {
        return Observable.just("0")
      }
    }
    
    return executeRequest(request: request, mapping: mapping)
  }
  
  func getAllBakedAddress(bakerAddress: String) -> Observable<[String]> {
    let request = provider.rx.request(.getAllBakedAddresses(bakerAddress: bakerAddress))
    let mapping = { (response: Response) -> Observable<[String]> in
      do {
        if let json = try response.mapJSON() as? [String] {
          return Observable.just(json)
        }
        return Observable.just([])
      } catch {
        return Observable.just([])
      }
    }
    return executeRequest(request: request, mapping: mapping)
  }
  
  func getCurrentCycle() -> Observable<Int> {
    let request = provider.rx.request(.getHead())
    let mapping = { (response: Response) -> Observable<Int> in
      do {
        if let json = try response.mapJSON() as? [String: Any],
          let level = json["level"] as? Int {
          return Observable.just(level / 4096)
        }
        return Observable.just(0)
      } catch {
        return Observable.just(0)
      }
    }
    return executeRequest(request: request, mapping: mapping)
  }
  
  private func executeRequest<T>(request: PrimitiveSequence<SingleTrait, Response>, mapping: @escaping (Response) -> Observable<T> ) -> Observable<T> where T: Codable {
    return Observable.just(true)
      .flatMap { _ in
        request
      }
      .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
      .flatMap { (response) -> Observable<T> in
        return mapping(response)
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
