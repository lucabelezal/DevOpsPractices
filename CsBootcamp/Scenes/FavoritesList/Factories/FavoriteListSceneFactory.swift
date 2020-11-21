import UIKit.UIViewController

final class FavoritesListSceneFactory {
    static func make() -> UIViewController {
        let viewController = FavoritesListViewController()
        let presenter = FavoritesListPresenter(view: viewController)

        let coreDataStack = DefaultCoreDataStack.shared
        let favoriteMoviesListGateway = FavoriteMoviesListCoreDataGateway(coreDataStack: coreDataStack)
        let genresCacheGateway = GenresCacheCoreDataGateway(coreDataStack: coreDataStack)

        let interactor = FavoritesListInteractor(presenter: presenter, favoriteMoviesListGateway: favoriteMoviesListGateway, genresCacheGateway: genresCacheGateway)

        viewController.interactor = interactor

        return viewController
    }
}
