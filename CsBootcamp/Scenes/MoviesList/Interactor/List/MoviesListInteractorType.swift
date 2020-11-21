protocol MoviesListInteractorType {
    func fetchMovies(from page: Int)
    func reloadMovies()
    func movie(at index: Int) -> Movie
}
