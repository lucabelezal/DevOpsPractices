@testable
import CsBootcamp

import Nimble
import Quick

class MovieOverviewTableViewCellSpec: QuickSpec {
    typealias ViewModel = MovieDetailViewController.ViewModel

    override func spec() {
        describe("MovieOverviewTableViewCell", closure: {
            var sut: MovieOverviewTableViewCell!

            context("when it's initialized", closure: {
                beforeEach {
                    sut = MovieOverviewTableViewCell(style: .default, reuseIdentifier: nil)
                }

                it("should setup the view hierarchy ", closure: {
                    expect(sut.contentView.subviews).to(contain([sut.overviewLabel]))
                })

                context("and cell data is set", closure: {
                    let viewModel = MovieOverviewTableViewCell.ViewModel(overview: "")

                    beforeEach {
                        sut.setup(viewModel: viewModel)
                    }

                    it("should build a cell with correct data", closure: {
                        expect(sut.overviewLabel.text) == viewModel.overview
                    })
                })
            })
        })
    }
}
