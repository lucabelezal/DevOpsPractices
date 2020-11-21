protocol MoviesListGateway {
    func fetchMovies(page: Int, _ completion: @escaping (Result<[Movie]>) -> ())
}
