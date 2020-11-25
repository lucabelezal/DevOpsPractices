import Firebase
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