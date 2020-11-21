import Foundation

final class MovieDetailInteractor: MovieDetailInteractorType, MovieDetailFavoriteInteractorType {
    
    var movie: Movie?
    var genres: [Genre]?

    private let presenter: MovieDetailPresenterType
    private let genresCacheGateway: GenresCacheGateway
    private let favoriteMoviesListGateway: FavoriteMoviesListGateway
    
    init(presenter: MovieDetailPresenterType, genresGateway: GenresCacheGateway, favoriteMoviesListGateway: FavoriteMoviesListGateway) {
        self.presenter = presenter
        self.genresCacheGateway = genresGateway
        self.favoriteMoviesListGateway = favoriteMoviesListGateway
    }
    
    private func createResponse(fromMovie movie: Movie, genres: [Genre]) -> FetchMovieDetailResponse {
        
        let genreNames = genres.map { genre in genre.name }
        let isFavoriteResult = self.favoriteMoviesListGateway.isMovieFavorite(movie)
        let isFavorite = isFavoriteResult.value ?? false
        
        return FetchMovieDetailResponse(
            posterPath: movie.posterPath,
            releaseDate: movie.releaseDate,
            title: movie.title,
            overview: movie.overview,
            isFavorite: isFavorite,
            genreNames: genreNames
        )
    }
    
    // MARK: MovieDetailInteractorType
    
    func fetchDetail(of movie: Movie) {
        
        genresCacheGateway.fetchGenres(withIds: movie.genreIds) { [weak self] result in

            guard let `self` = self else { return }
            
            if case let .success(genres) = result {
                
                self.movie = movie
                self.genres = genres
                
                let response = self.createResponse(fromMovie: movie, genres: genres)
                self.presenter.presentMovie(response: response)
            }
        }
    }
    
    // MARK: MovieDetailFavoriteInteractorType
    
    func toggleMovieFavorite() {
        guard let movie = movie,
            let genres = genres else { return }
        let result = favoriteMoviesListGateway.toggleMovieFavorite(movie)
        
        if case .success = result {
            let response = self.createResponse(fromMovie: movie, genres: genres)
            presenter.presentMovie(response: response)
        }
    }
}
