@testable
import CSBootcamp

import Nimble
import Quick

class MovieDetailViewControllerSpec: QuickSpec {
    typealias ViewModel = MovieDetailViewController.ViewModel
    typealias PosterViewModel = MoviePosterTableViewCell.ViewModel
    typealias TextViewModel = MovieTextTableViewCell.ViewModel
    typealias OverviewViewModel = MovieOverviewTableViewCell.ViewModel

    override func spec() {
        describe("MovieDetailViewController") {
            var sut: MovieDetailViewController!
            context("when it is initialized") {
                let movie = Movie(id: 0, genreIds: [], title: "", overview: "", releaseDate: Date(), posterPath: "")

                beforeEach {
                    sut = MovieDetailViewController(movie: movie)
                }

                it("should setup the view hierarchy") {
                    expect(sut.view.subviews).to(contain(sut.tableView))
                }

                context("and display movie detail is called") {
                    let viewModel = MovieDetailViewController.ViewModel(
                        poster: MoviePosterTableViewCell.ViewModel(
                            imageURL: URL(string: "url.com")!,
                            title: "",
                            isFavoriteImage: UIImage()
                        ),
                        releaseDate: MovieTextTableViewCell.ViewModel(description: ""),
                        genres: MovieTextTableViewCell.ViewModel(description: ""),
                        overview: MovieOverviewTableViewCell.ViewModel(overview: "")
                    )

                    beforeEach {
                        sut.displayMovieDetail(viewModel: viewModel)
                    }

                    it("should set the data source view model") {
                        expect(sut.dataSource.viewModel) == viewModel
                    }
                }

                context("and view will appear") {
                    var interactor: MovieDetailInteractorSpy!

                    beforeEach {
                        interactor = MovieDetailInteractorSpy()
                        sut.interactor = interactor
                        sut.beginAppearanceTransition(true, animated: false)
                        sut.endAppearanceTransition()
                    }

                    it("the interactor should call the fetch movie method") {
                        expect(interactor.isFetchDetailOfMovieCalled) == true
                    }
                }
            }
        }
    }
}

class MovieDetailInteractorSpy: MovieDetailInteractorType {
    var isFetchDetailOfMovieCalled = false

    func fetchDetail(of _: Movie) {
        isFetchDetailOfMovieCalled = true
    }
}
