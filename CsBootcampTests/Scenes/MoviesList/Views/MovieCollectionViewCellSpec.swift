@testable
import CsBootcamp

import Quick
import Nimble
import Kingfisher

class MovieCollectionViewCellSpec: QuickSpec {
    
    override func spec() {
        
        describe("MovieCollectionViewCell") {
            
            var sut: MovieCollectionViewCell!
                        
            context("when initialized") {
                
                beforeEach {
                    sut = MovieCollectionViewCell(frame: .zero)
                }
                
                it("should setup the view hierarchy") {
                    expect(sut.contentView.subviews).to(contain([sut.titleLabel, sut.imageView]))
                }
                
                it("should set the content view background color") {
                    expect(sut.contentView.backgroundColor).to(equal(UIColor.Bootcamp.darkBlue))
                }
                
                context("and setup") {
                    
                    let viewModel = MovieCollectionViewCell.ViewModel(
                        imageURL: URL(string: "image.com")!,
                        title: "title",
                        favoriteButtonImage: UIImage()
                    )
                    
                    beforeEach {
                        sut.setup(viewModel: viewModel)
                    }
                    
                    it("should set label text") {
                        expect(sut.titleLabel.text).to(equal(viewModel.title))
                    }
                }
            }
        }
    }
}
