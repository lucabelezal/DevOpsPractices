protocol GenresCacheGateway {
    func addGenres(_ genres: [Genre], _ completion: @escaping (Result<Void>) -> Void)
    func fetchGenres(withIds ids: [Int], _ completion: @escaping (Result<[Genre]>) -> Void)
    func fetchGenres(_ completion: @escaping (Result<[Genre]>) -> Void)
}
