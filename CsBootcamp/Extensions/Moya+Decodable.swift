import Moya

extension MoyaProvider {
    func requestDecodable<T: Decodable>(_ target: Target, jsonDecoder: JSONDecoder, _ completion: @escaping (Result<T>) -> Void) {
        request(target) { result in
            switch result {
            case .success(let value):
                do {
                    let decoded = try jsonDecoder.decode(T.self, from: value.data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
