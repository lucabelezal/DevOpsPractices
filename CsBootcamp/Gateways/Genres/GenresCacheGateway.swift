protocol GenresCacheGateway {
    func addGenres(_ genres: [Genre], _ completion: @escaping (Result<Void>) -> ())
    func fetchGenres(withIds ids: [Int], _ completion: @escaping (Result<[Genre]>) -> ())
    func fetchGenres(_ completion: @escaping (Result<[Genre]>) -> ())
}
