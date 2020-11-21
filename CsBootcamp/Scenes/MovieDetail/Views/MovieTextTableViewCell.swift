import UIKit

final class MovieTextTableViewCell: UITableViewCell {
    
    static var cellHeight: CGFloat = CGFloat(44).proportionalToWidth
    
    lazy var textLabelCell: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.black
        
        return label
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
        self.textLabelCell.text = viewModel.description
    }
    
    private func setupViewHierarchy() {
        contentView.addSubview(textLabelCell)
    }
    
    private func setupConstraints() {
        textLabelCell
            .topAnchor(equalTo: contentView.topAnchor)
            .bottomAnchor(equalTo: contentView.bottomAnchor)
            .leadingAnchor(equalTo: contentView.leadingAnchor, constant: 16)
            .trailingAnchor(equalTo: contentView.trailingAnchor, constant: 8)
    }
}

extension MovieTextTableViewCell {
    
    struct ViewModel {

        let description: String
    }
}

