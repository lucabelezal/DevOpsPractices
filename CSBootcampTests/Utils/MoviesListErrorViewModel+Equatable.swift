@testable
import CSBootcamp

extension MoviesListErrorViewModel: Equatable {
    public static func == (lhs: MoviesListErrorViewModel, rhs: MoviesListErrorViewModel) -> Bool {
        return lhs.image == rhs.image &&
            lhs.message == rhs.message
    }
}
