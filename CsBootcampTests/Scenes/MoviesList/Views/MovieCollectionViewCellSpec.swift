@testable
import CsBootcamp

import Quick
import Nimble
import Kingfisher

class MovieCollectionViewCellSpec: QuickSpec {
    
    override func spec() {
        
        describe("MovieCollectionViewCell") {
            
            var cell: MovieCollectionViewCell!
            
            context("when initialized with coder") {
                
                beforeEach {
                    let coder = NSCoder()
                    cell = MovieCollectionViewCell(coder: coder)
                }
                
                it("should be nil") {
                    expect(cell).to(beNil())
                }
            }
            
            context("when initialized") {
                
                beforeEach {
                    cell = MovieCollectionViewCell(frame: .zero)
                }
                
                it("should setup the view hierarchy") {
                    expect(cell.contentView.subviews).to(contain([cell.titleLabel, cell.imageView]))
                }
                
                it("should set the content view background color") {
                    expect(cell.contentView.backgroundColor).to(equal(UIColor.Bootcamp.darkBlue))
                }
                
                context("and setup") {
                    
                    let viewModel = MovieCollectionViewCell.ViewModel(
                        imageURL: URL(string: "image.com")!,
                        title: "title",
                        favoriteButtonImage: UIImage()
                    )
                    
                    beforeEach {
                        cell.setup(viewModel: viewModel)
                    }
                    
                    it("should set label text") {
                        expect(cell.titleLabel.text).to(equal(viewModel.title))
                    }
                    
                    it("should config imageview fetch") {
                        expect(cell.imageView.kf.webURL).to(be(viewModel.imageURL))
                    }
                }
            }
        }
    }
}
