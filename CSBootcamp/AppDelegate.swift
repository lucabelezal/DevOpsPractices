import Firebase
import Sentry
import UIKit

final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var genresCacher: GenresCacher?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // TODO
        let docsPath = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first! // swiftlint:disable:this force_unwrapping
        print(docsPath)

        cacheGenresIfNeeded()
        window = MainWindowFactory.make()
        setupSearchBarAppearance()

        FirebaseApp.configure()

        SentrySDK.start { options in
            options.dsn = "https://582515bed99d4474aab394023051c88b@o481207.ingest.sentry.io/5535567"
            options.debug = true // Enabled debug when first installing is always helpful
        }

        SentrySDK.capture(message: "My first test message")
//        SentrySDK.crash()

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
