@testable
import CsBootcamp

import Quick
import Nimble

class MovieOverviewTableViewCellSpec: QuickSpec {
    
    typealias ViewModel = MovieDetailViewController.ViewModel
    
    override func spec() {
        
        describe("MovieOverviewTableViewCell", closure:{
            
            var sut: MovieOverviewTableViewCell!
            var cell: MovieOverviewTableViewCell!
            
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
                        expect(sut.overviewLabel.text).to(equal(viewModel.overview))
                    })
                })
            })
            
            context("When is initialized with coder", {
                
                beforeEach {
                    let coder = NSCoder()
                    cell = MovieOverviewTableViewCell(coder: coder)
                }
                
                it("should be nil", closure: {
                    expect(cell).to(beNil())
                })
            })
        })
        
    }
    
}
