import Foundation

struct Delegator: Codable {
  let id: Int
  let address: String
  let vip: String
  let joinedDate: String
  let joinedCycle: Int
  let lastUpdate: String
  let created: String
  let manager: String
  let balance: Double
  
  enum CodingKeys: String, CodingKey {
    case id, address, vip, created, manager, balance
    case joinedDate = "joined_date"
    case joinedCycle = "joined_cycle"
    case lastUpdate = "last_update"
  }

  func daysWithXTZMaster() -> String {
    let calendar = Calendar.current
    let today = calendar.startOfDay(for: Date())
    let joined = calendar.startOfDay(for: ISO8601DateFormatter().date(from: joinedDate) ?? Date())
    let components = calendar.dateComponents([.day], from: joined, to: today)
    return "\(components.day ?? 0) days"
  }

  var displayAddress: String {
    return address.prefix(10) + "***************" + address.dropFirst(25)
  }
}
