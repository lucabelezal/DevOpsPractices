import UIKit

final class UITabBarControllerFactory {
    static func make(with viewControllers: UIViewController...) -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.barTintColor = UIColor.Bootcamp.yellow
        tabBarController.tabBar.tintColor = .black
        tabBarController.tabBar.isTranslucent = false
        tabBarController.viewControllers = viewControllers
        return tabBarController
    }
}
