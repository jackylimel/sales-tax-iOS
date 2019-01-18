import Foundation

struct Account: Codable {
  let name: AccountName
  let manager: AccountName
  let balance: Double
  let staking: Double
  
  enum CodingKeys: String, CodingKey {
    case name
    case manager
    case balance
    case staking = "staking_balance"
  }
}

struct AccountName: Codable {
  let tz: String
}
