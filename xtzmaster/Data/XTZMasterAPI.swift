import Foundation
import Moya

enum XTZMasterAPI {
  case getAccount(accountAddress: String)
  case getStakingBalance(accountAddress: String)
  case getRewardSplit(accountAddress: String, cycle: Int)
  case getAllBakedAddresses(bakerAddress: String)
}

extension XTZMasterAPI: TargetType {
  
  var baseURL: URL {
    return URL(string: "https://api5.tzscan.io/v2")!
  }
  
  var path: String {
    switch self {
    case let .getAccount(accountAddress):
      return "/node_account/\(accountAddress)"
    case let .getStakingBalance(accountAddress):
      return "/staking_balance/\(accountAddress)"
    case let .getRewardSplit(accountAddress, _):
      return "/rewards_split/\(accountAddress)"
    case let .getAllBakedAddresses(bakerAddress):
      return "/operations/\(bakerAddress)"
    }
  }
  
  var method: Moya.Method {
    return .get
  }
  
  var task: Task {
    switch self {
    case .getAccount, .getStakingBalance:
      return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
    case let .getRewardSplit(_, cycle):
      return .requestParameters(parameters: ["cycle": cycle, "number": 999], encoding: URLEncoding.queryString)
    case .getAllBakedAddresses:
      return .requestParameters(parameters: ["type": "Transaction", "number": 999, "p": 0], encoding: URLEncoding.queryString)
    }
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var headers: [String : String]? {
    return ["Content-type": "application/json"]
  }
}
