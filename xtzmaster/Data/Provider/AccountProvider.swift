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
  
  func getAllDelegators() -> Observable<[Delegator]> {
    let request = provider.rx.request(.getDelegators)
    let mapping = { response -> Observable<[Delegator]> in
      self.mapResponseTo(response: response)
    }
    return executeRequest(request: request, mapping: mapping)
  }
  
  func getRewardSplit(delegatorAddress: String, cycle: Int) -> Observable<RewardSplit> {
    let request = provider.rx.request(.getRewardSplit(delegatorAddress: delegatorAddress, cycle: cycle))
    let mapping = { response -> Observable<RewardSplit> in
      self.mapResponseTo(response: response)
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
