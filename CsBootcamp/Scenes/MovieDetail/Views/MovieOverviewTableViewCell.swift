import UIKit

final class MovieOverviewTableViewCell: UITableViewCell {
    lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        return label
    }()

    override init(style _: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViewHierarchy()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        return nil
    }

    func setup(viewModel: ViewModel) {
        overviewLabel.text = viewModel.overview
    }

    private func setupViewHierarchy() {
        contentView.addSubview(overviewLabel)
    }

    private func setupConstraints() {
        overviewLabel
            .topAnchor(equalTo: contentView.topAnchor, constant: 8)
            .bottomAnchor(equalTo: contentView.bottomAnchor, constant: -8)
            .leadingAnchor(equalTo: contentView.leadingAnchor, constant: 16)
            .trailingAnchor(equalTo: contentView.trailingAnchor, constant: -8)
    }
}

extension MovieOverviewTableViewCell {
    struct ViewModel {
        let overview: String
    }
}
