import UIKit

public final class MoviePosterTableViewCell: UITableViewCell {
    
    private let imageFetcher: ImageFetcher = KingfisherImageFetcher()
    
    static var cellHeight: CGFloat = CGFloat(250).proportionalToWidth
    
    var favoriteButtonTapped: (() -> ())?
    
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(favoriteButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViewHierarchy()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    func setup(viewModel: ViewModel) {
        self.titleLabel.text = viewModel.title
        imageFetcher.fetchImage(from: viewModel.imageURL, to: posterImageView) {}
        favoriteButton.setImage(viewModel.isFavoriteImage, for: .normal)
    }
    
    private func setupViewHierarchy() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(favoriteButton)
    }
    
    private func setupConstraints() {
        posterImageView
            .topAnchor(equalTo: contentView.topAnchor)
            .bottomAnchor(equalTo: titleLabel.topAnchor)
            .trailingAnchor(equalTo: contentView.trailingAnchor)
            .leadingAnchor(equalTo: contentView.leadingAnchor)
    
        titleLabel
            .heightAnchor(equalTo: heightAnchor, multiplier: 0.2)
            .bottomAnchor(equalTo: contentView.bottomAnchor)
            .leadingAnchor(equalTo: contentView.leadingAnchor, constant: 16)
            .trailingAnchor(equalTo: contentView.trailingAnchor, constant: -40)
        
        favoriteButton
            .topAnchor(equalTo: posterImageView.bottomAnchor)
            .bottomAnchor(equalTo: contentView.bottomAnchor)
            .trailingAnchor(equalTo: contentView.trailingAnchor, constant: -16)
    }
    
    @objc private func favoriteButtonAction(_ sender: AnyObject) {
        favoriteButtonTapped?()
    }
}

extension MoviePosterTableViewCell {
    public struct ViewModel {
        let imageURL: URL
        let title: String
        let isFavoriteImage: UIImage
    }
}

