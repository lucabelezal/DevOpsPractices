@testable
import CsBootcamp

extension Movie: Equatable {
    public static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id &&
            lhs.genreIds == rhs.genreIds &&
            lhs.title == rhs.title &&
            lhs.overview == rhs.overview &&
            lhs.releaseDate == rhs.releaseDate &&
            lhs.posterPath == rhs.posterPath
    }
}
