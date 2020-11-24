final class MovieFilterTransaction {
    private var commitSnapshot: (
        genreFilter: Genre?,
        releaseYearFilter: Int?,
        genreFilterIndex: Int?,
        releaseYearFilterIndex: Int?
    )

    var genreFilter: Genre?
    var releaseYearFilter: Int?

    var genreFilterIndex: Int?
    var releaseYearFilterIndex: Int?

    init() {
        commitSnapshot = (nil, nil, nil, nil)
    }

    var hasFilter: Bool {
        return genreFilter != nil || releaseYearFilter != nil
    }

    func clearFilter() {
        genreFilter = nil
        releaseYearFilter = nil
        genreFilterIndex = nil
        releaseYearFilterIndex = nil
    }

    func commit() {
        commitSnapshot = (genreFilter, releaseYearFilter, genreFilterIndex, releaseYearFilterIndex)
    }

    func rollback() {
        (genreFilter, releaseYearFilter, genreFilterIndex, releaseYearFilterIndex) = commitSnapshot
    }
}
