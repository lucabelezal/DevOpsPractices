import UIKit.UIViewController

final class MovieDetailSceneFactory {
    static func make(with movie: Movie) -> UIViewController {
        let viewController = MovieDetailViewController(movie: movie)
        let presenter = MovieDetailPresenter(view: viewController)

        let coreDataStack = DefaultCoreDataStack.shared

        let genresGateway = GenresCacheCoreDataGateway(coreDataStack: coreDataStack)
        let favoriteMoviesListGateway = FavoriteMoviesListCoreDataGateway(coreDataStack: coreDataStack)

        let interactor = MovieDetailInteractor(presenter: presenter, genresGateway: genresGateway, favoriteMoviesListGateway: favoriteMoviesListGateway)

        viewController.interactor = interactor
        viewController.movieDetailFavoriteInteractor = interactor

        return viewController
    }
}
