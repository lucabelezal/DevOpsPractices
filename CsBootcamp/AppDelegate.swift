import UIKit

final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var genresCacher: GenresCacher?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let docsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        print(docsPath)

        cacheGenresIfNeeded()
        window = MainWindowFactory.make()
        setupSearchBarAppearance()
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
