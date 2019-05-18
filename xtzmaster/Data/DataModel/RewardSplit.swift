struct RewardSplit: Codable {
  let address: String
  let cycle: String
  let balance: String
  let rewardShare: String
  let feeRate: String
  let rewards: String
  let rewardsBeforeFee: String
  let paid: Bool
  let paidTime: String
  let paidReference: String
  
  enum CodingKeys: String, CodingKey {
    case address, cycle, balance, rewards, paid
    case rewardShare = "reward_share"
    case feeRate = "fee_rate"
    case rewardsBeforeFee = "rewards_before_fee"
    case paidTime = "paid_time"
    case paidReference = "paid_reference"
  }
}
