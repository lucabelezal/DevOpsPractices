import Firebase
import Sentry
import UIKit

final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var genresCacher: GenresCacher?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        cacheGenresIfNeeded()
        window = MainWindowFactory.make()
        setupSearchBarAppearance()

        FirebaseApp.configure()

        SentrySDK.start { options in
            options.dsn = "https://582515bed99d4474aab394023051c88b@o481207.ingest.sentry.io/5535567"
            options.debug = true
        }

        return true
    }

    private func setupSearchBarAppearance() {
        let cancelButtonAppearance = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        cancelButtonAppearance.tintColor = UIColor.Bootcamp.darkBlue
    }

    func cacheGenresIfNeeded() {
        genresCacher = GenresCacherFactory.make()
        genresCacher?.cacheGenresIfNeeded()
    }
}
