@testable
import CsBootcamp

extension MovieCollectionViewCell.ViewModel: Equatable {
    public static func == (lhs: MovieCollectionViewCell.ViewModel, rhs: MovieCollectionViewCell.ViewModel) -> Bool {
        return lhs.imageURL == rhs.imageURL &&
            lhs.title == rhs.title
    }
}
