import UIKit

extension UISearchBar {
    func setTextBackgroundColor(_ color: UIColor) {
        subviews.forEach { view in
            if let textField = view.subviews.first(where: { view in view is UITextField }) as? UITextField {
                textField.backgroundColor = color
            }
        }
    }
}
