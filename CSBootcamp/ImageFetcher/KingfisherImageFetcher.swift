import Kingfisher

final class KingfisherImageFetcher: ImageFetcher {
    func fetchImage(from url: URL, to imageView: UIImageView, callback: @escaping () -> Void) {
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url, completionHandler: { _ in
            callback()
        })
    }
}
