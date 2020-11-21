import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {
    static var cellSize: CGSize {
        let width = CGFloat(160).proportionalToWidth
        let height = width * 1.65

        return CGSize(width: width, height: height)
    }

    var didFavoriteButtonPressed: ((AnyObject) -> Void)?

    private let imageFetcher: ImageFetcher = KingfisherImageFetcher()

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.Bootcamp.yellow
        label.numberOfLines = 2
        return label
    }()

    lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewHierarchy()
        setupConstraints()

        contentView.backgroundColor = UIColor.Bootcamp.darkBlue
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    func setup(viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        imageFetcher.fetchImage(from: viewModel.imageURL, to: imageView) { }
        favoriteButton.setImage(viewModel.favoriteButtonImage, for: .normal)
    }

    private func setupViewHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(favoriteButton)
    }

    private func setupConstraints() {
        imageView
            .topAnchor(equalTo: contentView.topAnchor)
            .leadingAnchor(equalTo: contentView.leadingAnchor)
            .trailingAnchor(equalTo: contentView.trailingAnchor)
            .heightAnchor(equalTo: bounds.width * 1.25)

        titleLabel
            .topAnchor(equalTo: imageView.bottomAnchor)
            .leadingAnchor(equalTo: contentView.leadingAnchor, constant: 16)
            .bottomAnchor(equalTo: contentView.bottomAnchor)
            .trailingAnchor(equalTo: contentView.trailingAnchor, constant: -40)

        favoriteButton
            .topAnchor(equalTo: imageView.bottomAnchor)
            .bottomAnchor(equalTo: contentView.bottomAnchor)
            .trailingAnchor(equalTo: contentView.trailingAnchor, constant: -16)
    }

    @objc private func favoriteButtonTapped(_ sender: AnyObject) {
        didFavoriteButtonPressed?(sender)
    }
}

extension MovieCollectionViewCell {
    struct ViewModel {
        let imageURL: URL
        let title: String
        let favoriteButtonImage: UIImage
    }
}
