@testable
import CSBootcamp

import Nimble
import Quick

class MoviesListDataSourceSpec: QuickSpec {
    override func spec() {
        describe("MoviesListDataSource") {
            var collectionView: UICollectionView!
            var indicatorView: UIActivityIndicatorView!
            var moviesListDataSource: MoviesListDataSource!

            context("when initialized") {
                let viewModels = [
                    MovieCollectionViewCell.ViewModel(imageURL: URL(string: "url.com")!, title: "", favoriteButtonImage: UIImage()),
                ]

                beforeEach {
                    collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
                    indicatorView = UIActivityIndicatorView(frame: .zero)
                    moviesListDataSource = MoviesListDataSource(collectionView: collectionView, indicatorView: indicatorView)
                    moviesListDataSource.viewModels = viewModels
                }

                it("should set itself as datasource and delegate of collection view") {
                    expect(collectionView.dataSource).to(be(moviesListDataSource))
                    expect(collectionView.delegate).to(be(moviesListDataSource))
                }

                context("and dequeue movie collection view cell is called") {
                    var cell: MovieCollectionViewCell?

                    beforeEach {
                        let indexPath = IndexPath(item: 0, section: 0)
                        cell = collectionView.dequeueReusableCell(MovieCollectionViewCell.self, for: indexPath)
                    }

                    it("should return a valid cell") {
                        expect(cell).notTo(beNil())
                    }
                }

                context("and number of items in section is called") {
                    var numberOfItems: Int!

                    beforeEach {
                        numberOfItems = moviesListDataSource
                            .collectionView(collectionView, numberOfItemsInSection: 0)
                    }

                    it("should return viewmodels count") {
                        expect(numberOfItems).to(be(viewModels.count))
                    }
                }

                context("and cell for item at index path is called") {
                    var cell: MovieCollectionViewCell?
                    let index = 0

                    beforeEach {
                        let indexPath = IndexPath(item: index, section: 0)
                        cell = moviesListDataSource.collectionView(collectionView, cellForItemAt: indexPath) as? MovieCollectionViewCell
                    }

                    it("should return a configured movie cell") {
                        expect(cell?.titleLabel.text) == viewModels[index].title
                    }
                }

                context("and size for cell at index path is called") {
                    var cellSize: CGSize!

                    beforeEach {
                        let indexPath = IndexPath(item: 0, section: 0)
                        cellSize = moviesListDataSource.collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: indexPath)
                    }

                    it("should return movie collection view cell size") {
                        expect(cellSize) == MovieCollectionViewCell.cellSize
                    }
                }
            }
        }
    }
}
