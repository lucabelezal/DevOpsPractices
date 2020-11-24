import UIKit

final class ActivityIndicatorFooterView: UICollectionReusableView {
    weak var activityIndicator: UIActivityIndicatorView?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(activityIndicator: UIActivityIndicatorView) {
        setupViewHierarchy(activityIndicator: activityIndicator)
        setupConstraints(activityIndicator: activityIndicator)
    }

    private func setupViewHierarchy(activityIndicator: UIActivityIndicatorView) {
        addSubview(activityIndicator)
    }

    private func setupConstraints(activityIndicator: UIActivityIndicatorView) {
        activityIndicator
            .centerXAnchor(equalTo: centerXAnchor)
            .centerYAnchor(equalTo: centerYAnchor)
    }
}
