import Foundation

struct Account: Codable {
  let name: AccountName
  let manager: AccountName
  let balance: Double
  let staking: Double
  let cycle: Int
  let timeToNextReward: TimeToNextReward
  let totalCap: Double
  let usedCap: Double
  let availableCap: Double
  let usedCapPercent: Double
  let availableCapPercent: Double
  
  enum CodingKeys: String, CodingKey {
    case name
    case manager
    case balance
    case cycle
    case staking = "staking_balance"
    case timeToNextReward = "time_to_next_reward"
    case totalCap = "total_cap"
    case usedCap = "used_cap"
    case availableCap = "available_cap"
    case usedCapPercent = "used_cap_percent"
    case availableCapPercent = "available_cap_percent"
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
