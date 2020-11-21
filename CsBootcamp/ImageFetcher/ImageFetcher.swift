import UIKit

protocol ImageFetcher {
    func fetchImage(from url: URL, to imageView: UIImageView, callback: @escaping () -> Void)
}

final class ImageFetcherStub: ImageFetcher {
    func fetchImage(from url: URL, to imageView: UIImageView, callback: @escaping () -> Void) {
        imageView.image = #imageLiteral(resourceName: "poster_stub")
        callback()
    }
}
