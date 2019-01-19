import Foundation
import Moya

enum XTZMasterAPI {
  case getAccount(accountAddress: String)
  case getRewardSplit(bakerAddress: String, delegatorAddress: String, cycle: Int)
  case getDelegators
}

extension XTZMasterAPI: TargetType {
  var baseURL: URL {
    return URL(string: "https://api.xtzmaster.com/v1")!
  }
  
  var path: String {
    switch self {
    case .getAccount:
      return "/node_account/index.php"
    case .getRewardSplit:
      return "/rewards_split/index.php"
    case .getDelegators:
      return "/delegators/index.php"
    }
  }
  
  var method: Moya.Method {
    return .get
  }
  
  var task: Task {
    switch self {
    case .getDelegators:
      return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
    case let .getAccount(accountAddress):
      return .requestParameters(parameters: ["address": accountAddress], encoding: URLEncoding.queryString)
    case let .getRewardSplit(bakerAddress, delegatorAddress, cycle):
      return .requestParameters(parameters: ["baker": bakerAddress, "delegator": delegatorAddress, "cycle": cycle], encoding: URLEncoding.queryString)
    }
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var headers: [String : String]? {
    return [:]
  }
}
