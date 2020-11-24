@testable
import CSBootcamp

extension MoviesListViewModel: Equatable {
    public static func == (lhs: MoviesListViewModel, rhs: MoviesListViewModel) -> Bool {
        return lhs.cellViewModels == rhs.cellViewModels
    }
}
