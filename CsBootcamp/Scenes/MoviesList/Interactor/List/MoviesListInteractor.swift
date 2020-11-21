import Foundation

final class MoviesListInteractor: MoviesListInteractorType, MovieListFavoriteInteractorType {
    
    private var movies = [Movie]()
    
    private let presenter: MoviesListPresenterType
    private let moviesListGateway: MoviesListGateway
    private let favoriteMoviesListGateway: FavoriteMoviesListGateway
    
    init(presenter: MoviesListPresenterType, moviesListGateway: MoviesListGateway, favoriteMoviesListGateway: FavoriteMoviesListGateway) {
        self.presenter = presenter
        self.moviesListGateway = moviesListGateway
        self.favoriteMoviesListGateway = favoriteMoviesListGateway
    }
    
    func movie(at index: Int) -> Movie {
        return movies[index]
    }
    
    func reloadMovies() {
        presentResponses(with: movies)
    }
    
    func fetchMovies(from page: Int) {
        moviesListGateway.fetchMovies(page: page) { [weak self] result in
    
            guard let `self` = self else { return }
            
            switch result {
                
            case .success(let movies):
                
                self.movies.append(contentsOf: movies)
                self.presentResponses(with: self.movies)
            case .failure:
                self.presenter.presentError()
            }
        }
    }
    
    private func presentResponses(with movies: [Movie]) {
        let responses = movies.map { movie -> FetchMoviesListResponse in
            
            let isMovieFavorite = self.favoriteMoviesListGateway
                .isMovieFavorite(movie).value ?? false
            
            return FetchMoviesListResponse(
                posterPath: movie.posterPath,
                title: movie.title,
                isFavorite: isMovieFavorite
            )
        }
        
        presenter.presentMovies(responses)
    }
    
    // MARK: MovieListFavoriteInteractorType
    
    func toggleMovieFavorite(_ movie: Movie) {
        _ = favoriteMoviesListGateway.toggleMovieFavorite(movie)
        presentResponses(with: movies)
    }
}

