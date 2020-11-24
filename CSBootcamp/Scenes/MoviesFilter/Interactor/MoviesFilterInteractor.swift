import Foundation

protocol MoviesFilterPresenterType: AnyObject {
    func presentFilterOptions(types: [String], releaseYearOption: Int?, genreOption: Genre?)
    func showFilterByGenres(_ genres: [Genre])
    func showFilterByReleaseDates(_ releaseYears: [Int])
}

final class MoviesFilterInteractor: MoviesFilterInteractorType {
    private let filterOptionTypes = ["Date", "Genres"]
    let presenter: MoviesFilterPresenterType
    let gateway: GenresCacheGateway

    private var genres: [Genre] = []
    private var releaseYears: [Int] = []

    init(presenter: MoviesFilterPresenterType, gateway: GenresCacheGateway) {
        self.presenter = presenter
        self.gateway = gateway
    }

    func fetchDetailOptionTypes(movieFilter: MovieFilterTransaction) {
        presenter.presentFilterOptions(types: filterOptionTypes, releaseYearOption: movieFilter.releaseYearFilter, genreOption: movieFilter.genreFilter)
    }

    func showFilterDetail(at index: Int) {
        if index == 0 {
            showFilterByReleaseDate()
        } else if index == 1 {
            showFilterByGenres()
        }
    }

    func genre(at index: Int) -> Genre {
        return genres[index]
    }

    func releaseYear(at index: Int) -> Int {
        return releaseYears[index]
    }

    private func showFilterByGenres() {
        gateway.fetchGenres { [weak self] result in
            guard let `self` = self else {
                return
            }

            if let value = result.value {
                self.genres = value
                self.presenter.showFilterByGenres(value)
            }
        }
    }

    private func showFilterByReleaseDate() {
        let currenteDate = Date()

        let calendar = Calendar.current
        let year = calendar.component(.year, from: currenteDate)

        releaseYears = (0 ..< 100).map { index in
            year - index
        }

        presenter.showFilterByReleaseDates(releaseYears)
    }
}
