@testable
import CsBootcamp

import Nimble
import Quick

class MoviesListPresenterSpec: QuickSpec {
    override func spec() {
        var view: MoviesListViewSpy!
        var presenter: MoviesListPresenter!

        describe("MoviesListPresenter") {
            context("when initialized") {
                beforeEach {
                    view = MoviesListViewSpy()
                    presenter = MoviesListPresenter(view: view)
                }

                context("and present movies is called") {
                    let movies = (0..<3).map { _ in
                        FetchMoviesListResponse(
                            posterPath: "", title: "", isFavorite: true
                        )
                    }

                    beforeEach {
                        presenter.presentMovies(movies)
                    }

                    let viewModel = MoviesListViewModel(cellViewModels: movies.map { movie in
                        MovieCollectionViewCell.ViewModel(
                            imageURL: APIBase.posterImageURL(path: movie.posterPath),
                            title: movie.title,
                            favoriteButtonImage: UIImage()
                        )
                    })

                    it("should transform into viewmodels and display") {
                        expect(view.displayMoviesCalled) == true
                        expect(view.displayMoviesArg) == viewModel
                    }
                }

                context("and present error is called") {
                    beforeEach {
                        presenter.presentError()
                    }

                    it("should create default viewmodel and display") {
                        expect(view.displayErrorCalled) == true
                        expect(view.displayErrorArg)
                            .to(equal(MoviesListErrorViewModel.defaultError))
                    }
                }
            }
        }
    }
}

class MoviesListViewSpy: MoviesListView {
    var displayMoviesCalled = false
    var displayMoviesArg: MoviesListViewModel?

    var displayErrorCalled = false
    var displayErrorArg: MoviesListErrorViewModel?

    func displayMovies(viewModel: MoviesListViewModel) {
        displayMoviesCalled = true
        displayMoviesArg = viewModel
    }

    func displayError(viewModel: MoviesListErrorViewModel) {
        displayErrorCalled = true
        displayErrorArg = viewModel
    }
}
