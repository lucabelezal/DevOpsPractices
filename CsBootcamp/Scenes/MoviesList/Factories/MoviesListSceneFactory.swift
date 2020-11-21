import UIKit.UIViewController

final class MoviesListSceneFactory {
    
    static func make() -> UIViewController {
        
        let viewController = MoviesListViewController()
        let presenter = MoviesListPresenter(view: viewController)
        
        let moviesListGateway = MoviesListGatewayFactory.make()
        let favoriteMoviesListGateway = FavoriteMoviesListGatewayFactory.make()
        let listInteractor = MoviesListInteractor(presenter: presenter, moviesListGateway: moviesListGateway, favoriteMoviesListGateway: favoriteMoviesListGateway)
        let showDetailInteractor = MoviesListShowDetailInteractor(showMovieDetailNavigator: viewController)
        
        viewController.listInteractor = listInteractor
        viewController.showDetailInteractor = showDetailInteractor
        viewController.favoriteInteractor = listInteractor
        
        return viewController
    }
}

final class MoviesListGatewayFactory {
    static func make() -> MoviesListGateway {
        return MoviesListMoyaGateway()
    }
}

final class FavoriteMoviesListGatewayFactory {
    static func make() -> FavoriteMoviesListGateway {
        return FavoriteMoviesListCoreDataGateway(coreDataStack: DefaultCoreDataStack.shared)
    }
}
