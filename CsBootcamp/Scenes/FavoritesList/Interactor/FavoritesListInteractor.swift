import Foundation

final class FavoritesListInteractor: FavoritesListInteractorType {
    
    private let presenter: FavoritesListPresenterType
    private let favoriteMoviesListGateway: FavoriteMoviesListGateway
    private let genresCacheGateway: GenresCacheGateway
    
    private var movies: [Movie]?
    
    init(presenter: FavoritesListPresenterType, favoriteMoviesListGateway: FavoriteMoviesListGateway, genresCacheGateway: GenresCacheGateway) {
        self.presenter = presenter
        self.favoriteMoviesListGateway = favoriteMoviesListGateway
        self.genresCacheGateway = genresCacheGateway
    }
    
    func fetchFavorites(filteringWithGenre genre: Genre?, releaseYear: Int?) {
        
        let result = favoriteMoviesListGateway.fetchMovies()
        if var movies = result.value {
            
            if let genre = genre {
                movies = filterMovies(movies, withGenre: genre)
            }
            
            if let releaseYear = releaseYear {
                movies = filterMovies(movies, withReleaseYear: releaseYear)
            }
            
            presentFavorites(movies)
        }
    }
    
    func removeFavorite(at index: Int) {
        
        guard var movies = movies else { return }
        
        let movie = movies[index]
        if favoriteMoviesListGateway.setMovie(movie, favorite: false).value != nil {
            movies.remove(at: index)
        }
        presentFavorites(movies)
    }
    
    private func presentFavorites(_ movies: [Movie]) {
        self.movies = movies
        presenter.presentFavorites(movies)
    }
    
    private func filterMovies(_ movies: [Movie], withGenre genre: Genre) -> [Movie] {
        
        return movies.filter { movie in
            movie.genreIds.contains(genre.id)
        }
    }
    
    private func filterMovies(_ movies: [Movie], withReleaseYear releaseYear: Int) -> [Movie] {
        
        let calendar = Calendar.current
        return movies.filter { movie in
            
            let yearComponent = calendar.component(.year, from: movie.releaseDate)
            return releaseYear == yearComponent
        }
    }
}
