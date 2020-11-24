@testable
import CSBootcamp

import Nimble
import Quick

class FavoritesListInteractorSpec: QuickSpec {
    override func spec() {
        describe("FavoritesListInteractor") {
            var presenter: FavoritesListPresenterSpy!
            var gateway: FavoriteMoviesListGatewayStub!
            var genresCacheGateway: GenresCacheGatewayStub!
            var sut: FavoritesListInteractor!

            context("when it's initialized") {
                beforeEach {
                    presenter = FavoritesListPresenterSpy()
                    gateway = FavoriteMoviesListGatewayStub()
                    genresCacheGateway = GenresCacheGatewayStub()
                    sut = FavoritesListInteractor(presenter: presenter, favoriteMoviesListGateway: gateway, genresCacheGateway: genresCacheGateway)
                }

                context("and result is failure") {
                    beforeEach {
                        let error = NSError(domain: "", code: 0, userInfo: nil) as Error
                        gateway.result = .failure(error)
                    }

                    context("and fetch movies is called") {
                        beforeEach {
                            sut.fetchFavorites(filteringWithGenre: nil, releaseYear: nil)
                        }

                        it("should not call present favorites") {
                            expect(presenter.isPresentFavoriteCalled) == false
                        }
                    }
                }

                context("and result is success") {
                    beforeEach {
                        gateway.result = .success([])
                    }

                    context("and fetch movies is called") {
                        beforeEach {
                            sut.fetchFavorites(filteringWithGenre: nil, releaseYear: nil)
                        }

                        it("should call present favorites") {
                            expect(presenter.isPresentFavoriteCalled) == true
                        }
                    }
                }
            }
        }
    }
}

final class FavoritesListPresenterSpy: FavoritesListPresenterType {
    var isPresentFavoriteCalled = false

    func presentFavorites(_: [Movie]) {
        isPresentFavoriteCalled = true
    }
}
