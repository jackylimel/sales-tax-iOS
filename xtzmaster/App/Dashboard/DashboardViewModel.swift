import RxSwift

class DashboardViewModel {
  let usecase = GetBakingInfoUseCase.shared
  
  func loadAddresses() -> Observable<[String]> {
    let getAddressObservable = usecase.getAllBakedAddresses(by: "tz1KfEsrtDaA1sX7vdM4qmEPWuSytuqCDp5j")
    let getCurrentCycleObservable = usecase.getCurrentCycle()
    
    return Observable.zip(getAddressObservable, getCurrentCycleObservable) { addresses, currentCycle in
      print("Current cycle: \(currentCycle)")
      return addresses
    }
  }
}
