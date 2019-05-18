import Foundation
import Moya

enum XTZMasterAPI {
  case getAccount(accountAddress: String)
  case getDelegators
  case getRewardSplit(delegatorAddress: String, cycle: Int)
}

extension XTZMasterAPI: TargetType {
  var baseURL: URL {
    return URL(string: "https://api.xtzmaster.com/v1")!
  }
  
  var path: String {
    switch self {
    case .getAccount:
      return "/node_account/index.php"
    case .getDelegators:
      return "/delegators/index.php"
    case .getRewardSplit:
      return "/rewards_export/index.php"
    }
  }
  
  var method: Moya.Method {
    return .get
  }
  
  var task: Task {
    switch self {
    case let .getAccount(accountAddress):
      return .requestParameters(parameters: ["address": accountAddress], encoding: URLEncoding.queryString)
    case .getDelegators:
      return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
    case let .getRewardSplit(delegatorAddress, cycle):
      return .requestParameters(parameters: ["delegator": delegatorAddress, "reward_cycle": cycle, "api_key": Constants.apiKey, "dataonly": 1], encoding: URLEncoding.queryString)
    }
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var headers: [String : String]? {
    return [:]
  }
}
