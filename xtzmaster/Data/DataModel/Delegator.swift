struct Delegator: Codable {
  let id: String
  let address: String
  let vip: String
  let joinedDate: String
  let joinedCycle: String
  let lastUpdate: String
  let created: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case address
    case vip
    case created
    case joinedDate = "joined_date"
    case joinedCycle = "joined_cycle"
    case lastUpdate = "last_update"
  }
}
