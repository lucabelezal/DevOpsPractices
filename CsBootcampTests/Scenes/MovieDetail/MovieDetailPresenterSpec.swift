@testable
import CsBootcamp

import Nimble
import Quick

class MovieDetailPresenterSpec: QuickSpec {
    override func spec() {
        describe("MovieDetailPresenter") {
            var viewController: MovieDetailViewControllerSpy!
            var sut: MovieDetailPresenter!

            context("when it is initialized") {
                beforeEach {
                    viewController = MovieDetailViewControllerSpy()
                    sut = MovieDetailPresenter(view: viewController)
                }

                context("and present movie is called") {
                    let response = FetchMovieDetailResponse(posterPath: "", releaseDate: Date(), title: "", overview: "", isFavorite: true, genreNames: [])

                    beforeEach {
                        sut.presentMovie(response: response)
                    }

                    it("should display movie detail") {
                        expect(viewController.isDisplayMovieDetailCalled) == true
                    }
                }
            }
        }
    }
}

class MovieDetailViewControllerSpy: MovieDetailView {
    var isDisplayMovieDetailCalled = false

    func displayMovieDetail(viewModel: MovieDetailViewController.ViewModel) {
        isDisplayMovieDetailCalled = true
    }
}
