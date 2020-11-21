import UIKit

extension CGFloat {
    var proportionalToWidth: CGFloat {
        return self * UIScreen.widthProportion
    }
}
