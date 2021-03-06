import UIKit

final class MoviesFilterDetailViewControllerFactory {
    static func make(withOptions options: [String], currentSelectedOptionIndex: Int?, didSelectOptionAtIndex: ((Int) -> Void)?) -> UIViewController {
        let viewController = MoviesFilterDetailViewController(options: options)
        viewController.didSelectOptionAtIndex = didSelectOptionAtIndex
        viewController.selectedOptionIndex = currentSelectedOptionIndex
        return viewController
    }
}
