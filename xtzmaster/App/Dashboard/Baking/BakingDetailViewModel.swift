import RxSwift

class BakingDetailViewModel {
  private let disposeBag = DisposeBag()
  private(set) var account = PublishSubject<Account>()
  private let accountUseCase = GetAccountInfoUseCase()
  
  func getAccount(by address: String) {
//    accountUseCase
//      .getAccount(by: address)
//      .map { [weak self] in
//        self?.account.onNext($0)
//      }
//      .subscribe()
//      .disposed(by: disposeBag)
  }
}
