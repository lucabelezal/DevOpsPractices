import UIKit

final class ActivityIndicatorFooterView: UICollectionReusableView {
    weak var activityIndicator: UIActivityIndicatorView?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(activityIndicator: UIActivityIndicatorView) {
        setupViewHierarchy(activityIndicator: activityIndicator)
        setupConstraints(activityIndicator: activityIndicator)
    }

    private func setupViewHierarchy(activityIndicator: UIActivityIndicatorView) {
        self.addSubview(activityIndicator)
    }

    private func setupConstraints(activityIndicator: UIActivityIndicatorView) {
        activityIndicator
            .centerXAnchor(equalTo: self.centerXAnchor)
            .centerYAnchor(equalTo: self.centerYAnchor)
    }
}
