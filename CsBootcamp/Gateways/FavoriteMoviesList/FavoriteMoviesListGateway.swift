protocol FavoriteMoviesListGateway {
    func toggleMovieFavorite(_ movie: Movie) -> Result<Bool>
    @discardableResult func setMovie(_ movie: Movie, favorite: Bool) -> Result<Void>
    func fetchMovies() -> Result<[Movie]>
    func isMovieFavorite(_ movie: Movie) -> Result<Bool>
}
