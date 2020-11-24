@testable
import CSBootcamp

import Nimble
import Quick

class MoviesListViewControllerSpec: QuickSpec {
    override func spec() {
        describe("MoviesListViewController") {
            var viewController: MoviesListViewController!

            context("when initialized") {
                beforeEach {
                    viewController = MoviesListViewController()
                }

                it("should set the title") {
                    expect(viewController.title).to(match("Movies"))
                }

                it("should setup the view hierarchy") {
                    let expectedSubviews: [UIView] = [
                        viewController.collectionView,
                        viewController.activityIndicator,
                        viewController.errorView
                    ]
                    expect(viewController.view.subviews)
                        .to(contain(expectedSubviews))
                }

                context("and view will appear") {
                    let interactor = MoviesListInteractorSpy()

                    beforeEach {
                        viewController.listInteractor = interactor
                        viewController.beginAppearanceTransition(true, animated: false)
                        viewController.endAppearanceTransition()
                    }

                    it("should change to loading state") {
                        expect(viewController.activityIndicator.isAnimating)
                            .to(beTrue())
                    }

                    it("should fetch movies") {
                        expect(interactor.fetchMoviesCalled) == true
                    }
                }

                context("and display movies is called") {
                    let viewModel = MoviesListViewModel(cellViewModels: (0 ..< 3).map { _ in
                        MovieCollectionViewCell.ViewModel(
                            imageURL: URL(string: "url.com")!,
                            title: "",
                            favoriteButtonImage: UIImage()
                        )
                    })
                    beforeEach {
                        viewController.displayMovies(viewModel: viewModel)
                    }

                    it("should change to list state") {
                        expect(viewController.collectionView.isHidden) == false
                    }

                    it("should set viewmodels to data source") {
                        expect(viewController.dataSource.viewModels)
                            .to(equal(viewModel.cellViewModels))
                    }
                }

                context("and display error is called") {
                    let errorViewModel = MoviesListErrorViewModel.defaultError

                    beforeEach {
                        viewController.displayError(viewModel: errorViewModel)
                    }

                    it("should change to error state") {
                        expect(viewController.errorView.isHidden) == false
                    }

                    it("should setup error view") {
                        expect(viewController.errorView.imageView.image)
                            .to(equal(errorViewModel.image))
                        expect(viewController.errorView.label.text)
                            .to(match(errorViewModel.message))
                    }
                }
            }

            describe("State") {
                var state: MoviesListViewController.State!

                context("list") {
                    beforeEach {
                        state = .list([])
                    }

                    it("should return collection view not hidden flag") {
                        expect(state.hidesCollectionView) == false
                    }

                    it("should return error view hidden flag") {
                        expect(state.hidesErrorView) == true
                    }

                    it("should return not animates activity indicator") {
                        expect(state.animatesActivityIndicator) == false
                    }
                }

                context("loading") {
                    beforeEach {
                        state = .loading
                    }

                    it("should return collection view hidden flag") {
                        expect(state.hidesCollectionView) == false
                    }

                    it("should return error view hidden flag") {
                        expect(state.hidesErrorView) == true
                    }

                    it("should return animates activity indicator") {
                        expect(state.animatesActivityIndicator) == true
                    }
                }

                context("error") {
                    beforeEach {
                        let errorViewModel = MoviesListErrorViewModel.defaultError
                        state = .error(errorViewModel)
                    }

                    it("should return collection view hidden flag") {
                        expect(state.hidesCollectionView) == true
                    }

                    it("should return error view not hidden flag") {
                        expect(state.hidesErrorView) == false
                    }

                    it("should return not animates activity indicator") {
                        expect(state.animatesActivityIndicator) == false
                    }
                }
            }
        }
    }
}

class MoviesListInteractorSpy: MoviesListInteractorType {
    var fetchMoviesCalled = false

    func fetchMovies(from _: Int) {
        fetchMoviesCalled = true
    }

    func movie(at _: Int) -> Movie {
        return Movie(id: 1, genreIds: [], title: "", overview: "", releaseDate: Date(), posterPath: "www.com")
    }

    func reloadMovies() {}
}
