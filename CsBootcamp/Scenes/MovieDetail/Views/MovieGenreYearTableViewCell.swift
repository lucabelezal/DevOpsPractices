import UIKit

class MovieGenreYearTableViewCell: UITableViewCell {
    let genreYearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black

        return label
    }()
}
