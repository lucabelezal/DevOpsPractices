import UIKit.UIActivityIndicatorView

extension UIActivityIndicatorView {
    func setAnimating(_ animating: Bool) {
        if animating {
            startAnimating()
        } else {
            stopAnimating()
        }
    }
}
