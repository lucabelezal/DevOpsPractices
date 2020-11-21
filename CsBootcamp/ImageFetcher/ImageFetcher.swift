import UIKit

protocol ImageFetcher {
    
    func fetchImage(from url: URL, to imageView: UIImageView, callback: @escaping () -> ())
}

final class ImageFetcherStub: ImageFetcher {
    
    func fetchImage(from url: URL, to imageView: UIImageView, callback: @escaping () -> ()) {
        
        imageView.image = #imageLiteral(resourceName: "poster_stub")
        callback()
    }
}
