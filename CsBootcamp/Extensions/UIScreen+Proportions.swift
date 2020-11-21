import UIKit

extension UIScreen {
    private static let iPhone6Width: CGFloat = 375
    
    static var widthProportion: CGFloat {
        return main.bounds.width/iPhone6Width
    }
}
