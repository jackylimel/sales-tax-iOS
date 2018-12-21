import Foundation

struct Account: Codable {
  let name: AccountName
  let manager: AccountName
  let balance: Int
}

struct AccountName: Codable {
  let tz: String
}
