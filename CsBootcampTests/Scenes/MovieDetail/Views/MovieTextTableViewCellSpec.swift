@testable
import CsBootcamp

import Quick
import Nimble

class MovieTextTableViewCellSpec: QuickSpec {
    
    override func spec() {
        
        typealias ViewModel = MovieDetailViewController.ViewModel
    
        describe("MovieTextTableViewCell") {
        
            var sut : MovieTextTableViewCell!
            
            context("When is initialized", closure: {
                
                beforeEach {
                    sut = MovieTextTableViewCell()
                }
                
                it("should call setupViewHierarchy  method", closure: {
                    expect(sut.contentView.subviews).to(contain(sut.textLabelCell))
                })
                
                context("When setup method is called", closure: {
                    
                    let viewModel = MovieTextTableViewCell.ViewModel(description: "")
                    
                    beforeEach {
                        sut.setup(viewModel: viewModel)
                    }
                    
                    it("should set releaseDate value for  UILabel", closure: {
                        expect(sut.textLabelCell.text)
                            .to(equal(viewModel.description))
                    })
                })
            })
            
            context("When is initialized with coder", {
                
                beforeEach {
                    let coder = NSCoder()
                    sut = MovieTextTableViewCell(coder: coder)
                }
                
                it("should be nil", closure: {
                    expect(sut).to(beNil())
                })
            })
        }
    }
}
