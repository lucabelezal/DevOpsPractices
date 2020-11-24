import UIKit

protocol MovieDetailView: AnyObject {
    func displayMovieDetail(viewModel: MovieDetailViewController.ViewModel)
}

final class MovieDetailPresenter: MovieDetailPresenterType {
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter
    }()

    unowned let view: MovieDetailView

    init(view: MovieDetailView) {
        self.view = view
    }

    func presentMovie(response: FetchMovieDetailResponse) {
        let moviePosterUrl = APIBase.posterImageURL(path: response.posterPath)
        let releaseDateDescription = dateFormatter.string(from: response.releaseDate)
        let genresDescription = response.genreNames.joined(separator: ", ")
        let isFavoriteImage = response.isFavorite ? #imageLiteral(resourceName: "favorite_full_icon") : #imageLiteral(resourceName: "favorite_gray_icon")

        let moviePosterViewModel = MoviePosterTableViewCell.ViewModel(
            imageURL: moviePosterUrl,
            title: response.title,
            isFavoriteImage: isFavoriteImage
        )
        let genresViewModel = MovieTextTableViewCell.ViewModel(
            description: genresDescription
        )
        let releaseDateViewModel = MovieTextTableViewCell.ViewModel(
            description: releaseDateDescription
        )
        let overviewViewModel = MovieOverviewTableViewCell.ViewModel(
            overview: response.overview
        )

        let viewModel = MovieDetailViewController.ViewModel(
            poster: moviePosterViewModel,
            releaseDate: releaseDateViewModel,
            genres: genresViewModel,
            overview: overviewViewModel
        )

        view.displayMovieDetail(viewModel: viewModel)
    }
}
