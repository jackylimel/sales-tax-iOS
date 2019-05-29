import UIKit

class BakingDetailHelpViewController: UIViewController {

  @IBOutlet weak var currentBalanceCell: TwoRows!
  @IBOutlet weak var currentCycleCell: TwoRows!
  @IBOutlet weak var toNextRewardCell: TwoRows!
  @IBOutlet weak var withXTZMasterCell: TwoRows!
  @IBOutlet weak var joinedCycleCell: TwoRows!
  @IBOutlet weak var rewardCell: TwoRows!
  @IBOutlet weak var feeRateCell: TwoRows!
  @IBOutlet weak var unlockedCycleCell: TwoRows!
  @IBOutlet weak var balanceByCycleCell: TwoRows!
  @IBOutlet weak var rewardPaidOutCell: TwoRows!

  override func viewDidLoad() {
    self.navigationItem.title = R.string.localizable.help()

    currentBalanceCell.titleLabel.text = R.string.localizable.currentBalance()
    currentCycleCell.titleLabel.text = R.string.localizable.currentCycle()
    toNextRewardCell.titleLabel.text = R.string.localizable.toNextReward()
    withXTZMasterCell.titleLabel.text = R.string.localizable.withXTZMaster()
    joinedCycleCell.titleLabel.text = R.string.localizable.joinedCycle()
    rewardCell.titleLabel.text = R.string.localizable.reward()
    feeRateCell.titleLabel.text = R.string.localizable.feeRate()
    unlockedCycleCell.titleLabel.text = R.string.localizable.unlockedCycle()
    balanceByCycleCell.titleLabel.text = R.string.localizable.balanceByCycle("")
    rewardPaidOutCell.titleLabel.text = R.string.localizable.rewardPaid()

    currentBalanceCell.valueLabel.text = R.string.localizable.currentBalanceHelp()
    currentCycleCell.valueLabel.text = R.string.localizable.currentCycleHelp()
    toNextRewardCell.valueLabel.text = R.string.localizable.toNextRewardHelp()
    withXTZMasterCell.valueLabel.text = R.string.localizable.withXTZMasterHelp()
    joinedCycleCell.valueLabel.text = R.string.localizable.joinedCycleHelp()
    rewardCell.valueLabel.text = R.string.localizable.rewardHelp()
    feeRateCell.valueLabel.text = R.string.localizable.feeRateHelp()
    unlockedCycleCell.valueLabel.text = R.string.localizable.unlockedCycleHelp()
    balanceByCycleCell.valueLabel.text = R.string.localizable.balanceByCycleHelp()
    rewardPaidOutCell.valueLabel.text = R.string.localizable.rewardPaidHelp()
  }
}
