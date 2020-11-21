import UIKit

protocol FilterView: AnyObject {
    func displayFilterDetail(viewModels: [String])
    func displayFilterOptions(types: [String], options: [Int: String])
}

final class MoviesFilterPresenter: MoviesFilterPresenterType {
    private weak var view: FilterView?

    init(view: FilterView) {
        self.view = view
    }

    func presentFilterOptions(types: [String], releaseYearOption: Int?, genreOption: Genre?) {
        var options: [Int: String] = [:]
        releaseYearOption
            .map(self.releaseYearDescription)
            .map { options[0] = $0 }
        genreOption
            .map(self.genreDescription)
            .map { options[1] = $0 }

        view?.displayFilterOptions(types: types, options: options)
    }

    func showFilterByGenres(_ genres: [Genre]) {
        let genres = genres.map(genreDescription)
        view?.displayFilterDetail(viewModels: genres)
    }

    func showFilterByReleaseDates(_ releaseYears: [Int]) {
        let releaseYears = releaseYears.map(releaseYearDescription)
        view?.displayFilterDetail(viewModels: releaseYears)
    }

    private func genreDescription(_ genre: Genre) -> String {
        return genre.name
    }

    private func releaseYearDescription(_ releaseYear: Int) -> String {
        return String(releaseYear)
    }
}
