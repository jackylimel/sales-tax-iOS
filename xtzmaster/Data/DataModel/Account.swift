import Foundation

struct Account: Codable {
  let name: AccountName
  let manager: AccountName
  let balance: String
  var staking: String?
}

struct AccountName: Codable {
  let tz: String
}
