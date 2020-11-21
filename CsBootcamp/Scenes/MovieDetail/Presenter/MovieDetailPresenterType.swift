import Foundation

protocol MovieDetailPresenterType {
    func presentMovie(response: FetchMovieDetailResponse)
}

struct FetchMovieDetailResponse {
    let posterPath: String
    let releaseDate: Date
    let title: String
    let overview: String
    let isFavorite: Bool
    let genreNames: [String]
}
