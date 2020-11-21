protocol GenresListGateway {
    func fetchGenres(_ completion: @escaping (Result<[Genre]>) -> ())
}
