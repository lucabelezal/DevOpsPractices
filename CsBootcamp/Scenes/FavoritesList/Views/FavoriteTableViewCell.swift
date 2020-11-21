import UIKit

final class FavoriteTableViewCell: UITableViewCell {
    
    private let imagerFetcher: ImageFetcher = KingfisherImageFetcher()
    
    static var cellHeight: CGFloat = CGFloat(120).proportionalToWidth
    
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: CGFloat(18).proportionalToWidth)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: CGFloat(17).proportionalToWidth, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        
        return label
    }()
    
    lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: CGFloat(14).proportionalToWidth, weight: .ultraLight)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)

        setupViewHierarchy()
        setupContraints()
        
        contentView.backgroundColor = .white
        selectionStyle = .none
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewModel: ViewModel) {
        
        imagerFetcher.fetchImage(from: viewModel.posterUrl, to: posterImageView) {}
        self.titleLabel.text = viewModel.title
        self.releaseDateLabel.text = viewModel.releaseDate
        self.overviewLabel.text = viewModel.overview
    }
    
    private func setupViewHierarchy() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(overviewLabel)
    }
    
    private func setupContraints() {
        posterImageView
            .topAnchor(equalTo: contentView.topAnchor)
            .bottomAnchor(equalTo: contentView.bottomAnchor)
            .leadingAnchor(equalTo: contentView.leadingAnchor)
            .widthAnchor(equalTo: posterImageView.heightAnchor, multiplier: 0.8)
        
        titleLabel
            .topAnchor(equalTo: contentView.topAnchor, constant: CGFloat(16).proportionalToWidth)
            .leadingAnchor(equalTo: posterImageView.trailingAnchor, constant: CGFloat(8).proportionalToWidth)
    
    titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        overviewLabel
            .topAnchor(equalTo: titleLabel.bottomAnchor, constant: CGFloat(8).proportionalToWidth)
            .leadingAnchor(equalTo: titleLabel.leadingAnchor)
            .trailingAnchor(equalTo: contentView.trailingAnchor, constant: -8)
        
        releaseDateLabel
            .topAnchor(equalTo: titleLabel.topAnchor)
            .trailingAnchor(equalTo: contentView.trailingAnchor, constant: CGFloat(-8).proportionalToWidth)
            .leadingAnchor(equalTo: titleLabel.trailingAnchor, constant: CGFloat(8).proportionalToWidth)
        
    }
}

extension FavoriteTableViewCell {
    
    struct ViewModel: Equatable {
        
        let posterUrl: URL
        let title: String
        let releaseDate: String
        let overview: String
    }
    
}
