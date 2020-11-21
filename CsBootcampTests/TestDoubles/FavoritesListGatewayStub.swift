@testable
import CsBootcamp

final class FavoriteMoviesListGatewayStub: FavoriteMoviesListGateway {
    var isMovieFavoriteResultStub: Result<Bool>!
    var result: Result<[Movie]>!

    func toggleMovieFavorite(_: Movie) -> Result<Bool> {
        return .success(true)
    }

    func setMovie(_: Movie, favorite _: Bool) -> Result<Void> {
        return .success(())
    }

    func fetchMovies() -> Result<[Movie]> {
        return result
    }

    func isMovieFavorite(_: Movie) -> Result<Bool> {
        return isMovieFavoriteResultStub
    }
}
