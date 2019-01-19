struct RewardSplit: Codable {
  let delegator: String
  let cycle: String
  let balance: Double
  let rewards: Double
  let feeRate: Double
  let currentCycle: Int
  
  enum CodingKeys: String, CodingKey {
    case delegator
    case cycle
    case balance
    case rewards
    case currentCycle = "current_cycle"
    case feeRate = "fee_rate"
  }
}
