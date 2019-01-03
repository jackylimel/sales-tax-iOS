import RxSwift

class DashboardViewModel {
  let usecase = GetBakingInfoUseCase()
  
  func loadAddresses() -> Observable<[String]> {
    return usecase.getAllBakedAddresses(by: "tz1KfEsrtDaA1sX7vdM4qmEPWuSytuqCDp5j")
  }
}
