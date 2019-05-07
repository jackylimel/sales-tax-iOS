import Foundation

struct Account: Codable {
  let name: AccountName
  let manager: AccountName
  let balance: Double
  let staking: Double
  let cycle: Int
  let timeToNextReward: TimeToNextReward
  
  enum CodingKeys: String, CodingKey {
    case name
    case manager
    case balance
    case cycle
    case staking = "staking_balance"
    case timeToNextReward = "time_to_next_reward"
  }
  
  var address: String {
    return name.tz
  }

  func getTimeToNextReward() -> String {
    return timeToNextReward.displayString
  }
}

struct AccountName: Codable {
  let tz: String
}

struct TimeToNextReward: Codable {
  let days: Int
  let hours: Int
  let minutes: Int
  let datetime: String

  var displayString: String {
    return "\(days) days \(hours + 1) hours"
  }
}
