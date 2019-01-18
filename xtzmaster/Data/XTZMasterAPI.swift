import Foundation
import Moya

enum XTZMasterAPI {
  case getAccount(accountAddress: String)
  case getRewardSplit(accountAddress: String, delegatorAddress: String, cycle: Int)
  case getDelegators
}

extension XTZMasterAPI: TargetType {
  var baseURL: URL {
    return URL(string: "https://api.xtzmaster.com")!
  }
  
  var path: String {
    switch self {
    case .getAccount:
      return "/v1/node_account/index.php"
    case .getRewardSplit:
      return "/v1/rewards_split/"
    case .getDelegators:
      return "/get_delegators.php"
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
    case let .getRewardSplit(accountAddress, delegatorAddress, cycle):
      return .requestParameters(parameters: ["baker": accountAddress, "delegator": delegatorAddress, "cycle": cycle], encoding: URLEncoding.queryString)
    }
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var headers: [String : String]? {
    return [:]
  }
}
