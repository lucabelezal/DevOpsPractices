import UIKit

final class MoviesFilterSceneFactory {
    static func make(movieFilter: MovieFilterTransaction) -> UIViewController {
        let viewController = MoviesFilterViewController(movieFilter: movieFilter)
        let presenter = MoviesFilterPresenter(view: viewController)

        let gateway = GenresCacheCoreDataGateway(coreDataStack: DefaultCoreDataStack.shared)
        let interactor = MoviesFilterInteractor(presenter: presenter, gateway: gateway)
        viewController.moviesFilterInteractor = interactor

        return viewController
    }
}
