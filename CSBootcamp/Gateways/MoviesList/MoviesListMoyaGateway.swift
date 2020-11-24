import Moya

final class MoviesListMoyaGateway: MoviesListGateway {
    private let provider = MoyaProvider<MovieTarget>()
    private lazy var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    func fetchMovies(page: Int, _ completion: @escaping (Result<[Movie]>) -> Void) {
        provider.requestDecodable(.popular(page), jsonDecoder: jsonDecoder) { (result: Result<MovieList>) in
            let result = result.map { moviesList in moviesList.results }
            completion(result)
        }
    }
}
