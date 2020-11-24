import Moya

extension MoyaProvider {
    func requestDecodable<T: Decodable>(_ target: Target, jsonDecoder: JSONDecoder, _ completion: @escaping (Result<T>) -> Void) {
        request(target) { result in
            switch result {
            case let .success(value):
                do {
                    let decoded = try jsonDecoder.decode(T.self, from: value.data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
