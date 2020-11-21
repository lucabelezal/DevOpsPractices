@testable
import CsBootcamp

import Quick
import Nimble

class MovieDetailDataSourceSpec: QuickSpec {
    
    typealias ViewModel = MovieDetailViewController.ViewModel
    typealias PosterViewModel = MoviePosterTableViewCell.ViewModel
    typealias TextViewModel = MovieTextTableViewCell.ViewModel
    typealias OverviewViewModel = MovieOverviewTableViewCell.ViewModel
    
    override func spec() {
        
        describe("MovieDetailDataSource") {

            var tableView: UITableView!
            var sut: MovieDetailDataSource!
            var cell: UITableViewCell!
            var indexPath: IndexPath!
            var viewModel: ViewModel!
            
            beforeSuite {
                tableView = UITableView(frame: .zero)
                sut = MovieDetailDataSource(tableView: tableView)
            }
            
            context("when Datasource is initialized", closure: {
                
                beforeEach {
                    tableView = UITableView(frame: .zero)
                    sut = MovieDetailDataSource(tableView: tableView)
                }
                
                it("should init the Data Source and store the given view model", closure: {
                    expect(sut).notTo(beNil())
                })
                
                context("and view models are set") {
                    
                    beforeEach {
                        viewModel = MovieDetailViewController.ViewModel(
                            poster: MoviePosterTableViewCell.ViewModel(
                                imageURL: URL(string: "www.com")!,
                                title: "",
                                isFavoriteImage: UIImage()
                            ),
                            releaseDate: MovieTextTableViewCell.ViewModel(description: ""),
                            genres: MovieTextTableViewCell.ViewModel(description: ""),
                            overview: MovieOverviewTableViewCell.ViewModel(overview: "")
                        )
                        sut.viewModel = viewModel
                    }
                    
                    context("and number of rows in section is called", closure:{
                        
                        var rows = 0
                        
                        beforeEach {
                            rows = sut.tableView(tableView, numberOfRowsInSection: 0)
                        }
                        
                        it("should return 4 rows", closure: {
                            expect(rows).to(equal(4))
                        })
                        
                    })
                    
                    context("and the poster cell is builded", closure: {
                        
                        beforeEach {
                            indexPath = IndexPath(row: 0, section: 0)
                            cell = sut.tableView(tableView, cellForRowAt: indexPath) as? MoviePosterTableViewCell
                        }
                        
                        it("should not be nil", closure: {
                            expect(cell).notTo(beNil())
                        })
                        
                    })
                    
                    context("and the text cell is builded as a release date cell", closure: {
                        
                        beforeEach {
                            indexPath = IndexPath(row: 1, section: 0)
                            cell = sut.tableView(tableView, cellForRowAt: indexPath) as? MovieTextTableViewCell
                        }
                        
                        it("should not be nil", closure: {
                            expect(cell).notTo(beNil())
                        })
                    })
                    
                    context("and the text cell is builded as a genres cell", closure: {
                        
                        beforeEach {
                            indexPath = IndexPath(row: 2, section: 0)
                            cell = sut.tableView(tableView, cellForRowAt: indexPath) as? MovieTextTableViewCell
                        }
                        
                        it("should not be nil", closure: {
                            expect(cell).notTo(beNil())
                        })
                    })
                    
                    context("and the overview cell is builded", closure: {
                        
                        beforeEach {
                            indexPath = IndexPath(row: 3, section: 0)
                            cell = sut.tableView(tableView, cellForRowAt: indexPath) as? MovieOverviewTableViewCell
                        }
                        
                        it("should not be nil", closure: {
                            expect(cell).notTo(beNil())
                        })
                        
                    })
                    
                    context("and the heights for row is called", closure: {
                        
                        it("should return the correct height cell for a poster cell", closure: {
                            indexPath = IndexPath(row: 0, section: 0)
                            let height = sut.tableView(tableView, heightForRowAt: indexPath)
                            expect(height).to(equal(MoviePosterTableViewCell.cellHeight))
                        })
                        
                        it("should return the correct height cell for a release date cell", closure: {
                            indexPath = IndexPath(row: 1, section: 0)
                            let height = sut.tableView(tableView, heightForRowAt: indexPath)
                            expect(height).to(equal(MovieTextTableViewCell.cellHeight))
                        })
                        
                        it("should return the correct height cell for a genres cell", closure: {
                            indexPath = IndexPath(row: 2, section: 0)
                            let height = sut.tableView(tableView, heightForRowAt: indexPath)
                            expect(height).to(equal(MovieTextTableViewCell.cellHeight))
                        })
                        
                        it("should return the correct height cell for a overview cell", closure: {
                            indexPath = IndexPath(row: 3, section: 0)
                            let height = sut.tableView(tableView, heightForRowAt: indexPath)
                            expect(height).to(equal(UITableView.automaticDimension))
                        })
                    })
                }
            })
        }
    }
}
