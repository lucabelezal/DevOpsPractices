@testable
import CsBootcamp

import Nimble
import Quick

class MovieDetailInteractorSpec: QuickSpec {
    override func spec() {
        describe("MovieDetailInteractor") {
            context("when is initialized") {
                var sut: MovieDetailInteractor!
                var presenter: MovieDetailPresenterSpy!
                var genresGateway: GenresCacheGatewayStub!
                var favoriteGateway: FavoriteMoviesListGateway!

                beforeEach {
                    presenter = MovieDetailPresenterSpy()
                    genresGateway = GenresCacheGatewayStub()
                    genresGateway.stubbedResult = .success([])
                    favoriteGateway = FavoriteMoviesListGatewayFake()
                    sut = MovieDetailInteractor(presenter: presenter, genresGateway: genresGateway, favoriteMoviesListGateway: favoriteGateway)
                }

                context("when fetchDetailOfMovie is called") {
                    let movie = Movie(id: 0, genreIds: [], title: "", overview: "", releaseDate: Date(), posterPath: "")

                    beforeEach {
                        sut.fetchDetail(of: movie)
                    }

                    it("should call presentMovie") {
                        expect(presenter.isPresentMovieCalled) == true
                    }
                }
            }
        }
    }
}

class FavoriteMoviesListGatewayFake: FavoriteMoviesListGateway {
    func toggleMovieFavorite(_ movie: Movie) -> Result<Bool> {
        return .success(true)
    }

    func setMovie(_ movie: Movie, favorite: Bool) -> Result<Void> {
        return .success(())
    }

    func fetchMovies() -> Result<[Movie]> {
        return .success([])
    }

    func isMovieFavorite(_ movie: Movie) -> Result<Bool> {
        return .success(true)
    }
}

class GenresCacheGatewayStub: GenresCacheGateway {
    var stubbedResult: Result<[Genre]>!

    func fetchGenres(_ completion: @escaping (Result<[Genre]>) -> Void) {
    }

    func addGenres(_ genres: [Genre], _ completion: @escaping (Result<Void>) -> Void) {
    }

    func fetchGenres(withIds ids: [Int], _ completion: @escaping (Result<[Genre]>) -> Void) {
        completion(stubbedResult)
    }
}

class MovieDetailPresenterSpy: MovieDetailPresenterType {
    var isPresentMovieCalled = false

    func presentMovie(response: FetchMovieDetailResponse) {
        isPresentMovieCalled = true
    }
}
