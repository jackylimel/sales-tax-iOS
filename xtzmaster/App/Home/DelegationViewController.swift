import UIKit

class DelegationViewController: UIViewController {
    var account: String!
    @IBOutlet weak var qrCodeImageView: UIImageView!
    @IBOutlet weak var accountAddress: UILabel!
    @IBOutlet weak var copyButton: UIButton!

    override func viewDidLoad() {
        copyButton.layer.cornerRadius = 5
        accountAddress.text = account

        let image = QRCodeUtil.generateQRCodeImage(content: account, imageWidth: qrCodeImageView.frame.size.width)
        qrCodeImageView.image = image
        copyButton.addTarget(self, action: #selector(copyAddress), for: .touchUpInside)
    }

    @objc private func copyAddress() {
        UIPasteboard.general.string = account
        showTipMessage(message: NSLocalizedString("Address copied", comment: ""))
    }
}
