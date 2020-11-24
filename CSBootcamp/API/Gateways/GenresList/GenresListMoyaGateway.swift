import Moya
import Result

final class GenresListMoyaGateway: GenresListGateway {
    private let provider = MoyaProvider<GenreTarget>()
    private let jsonDecoder = JSONDecoder()

    func fetchGenres(_ completion: @escaping (Result<[Genre]>) -> Void) {
        provider.requestDecodable(.list, jsonDecoder: jsonDecoder) { (result: Result<GenreList>) in
            let result = result.map { genresList in genresList.genres }
            completion(result)
        }
    }
}
