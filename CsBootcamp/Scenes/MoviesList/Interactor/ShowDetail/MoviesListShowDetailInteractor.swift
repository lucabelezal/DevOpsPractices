protocol ShowMovieDetailNavigator: class {
    
    func navigate(toDetailOf movie: Movie)
}

final class MoviesListShowDetailInteractor: MoviesListShowDetailInteractorType {
    
    private weak var showMovieDetailNavigator: ShowMovieDetailNavigator?
    
    init(showMovieDetailNavigator: ShowMovieDetailNavigator) {
        self.showMovieDetailNavigator = showMovieDetailNavigator
    }
    
    func showDetail(forMovie movie: Movie) {
        showMovieDetailNavigator?.navigate(toDetailOf: movie)
    }
}
