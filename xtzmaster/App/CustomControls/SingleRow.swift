import UIKit

@IBDesignable
class SingleRow: DesignableView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var underlineLabel: UIView!
    override var nibName: String {
        get {
            return "SingleRow"
        }
        set {}
    }
}
