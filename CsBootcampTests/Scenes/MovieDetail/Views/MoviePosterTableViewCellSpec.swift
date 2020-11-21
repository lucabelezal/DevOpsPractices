@testable
import CsBootcamp

import Quick
import Nimble

class MoviePosterTableViewCellSpec: QuickSpec {
    
    typealias ViewModel = MovieDetailViewController.ViewModel
    
    override func spec() {
        
        describe("MoviePosterTableViewCell") {
            
            var sut: MoviePosterTableViewCell!
            
            context("when it's initialized") {
    
                beforeEach {
                    sut = MoviePosterTableViewCell(style: .default, reuseIdentifier: nil)
                }
                
                it("should setup the view hierarchy ") {
                    expect(sut.contentView.subviews).to(contain([sut.titleLabel, sut.posterImageView]))
                }
                
                context("and cell data is set") {
                    
                    let viewModel = MoviePosterTableViewCell.ViewModel(
                        imageURL: URL(string: "www.com")!,
                        title: "",
                        isFavoriteImage: UIImage()
                    )
                    
                    beforeEach {
                        sut.setup(viewModel: viewModel)
                    }
                    
                    it("should build a cell with correct data") {
                        expect(sut.titleLabel.text).to(equal(viewModel.title))
                    }
                }
            }
        }
    }
}
