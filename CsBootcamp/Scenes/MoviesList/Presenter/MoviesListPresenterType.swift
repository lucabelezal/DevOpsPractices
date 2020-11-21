protocol MoviesListPresenterType {
    func presentMovies(_ movies: [FetchMoviesListResponse])
    func presentError()
}

struct FetchMoviesListResponse: Equatable {
    
    let posterPath: String
    let title: String
    let isFavorite: Bool
}
