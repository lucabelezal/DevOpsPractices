import Foundation

final class GenresCacher {
    
    private static let cachedGenresKey = "cachedGenresKey"
    
    let genresListGateway: GenresListGateway
    let genresCacheGateway: GenresCacheGateway
    
    init(genresListGateway: GenresListGateway, genresCacheGateway: GenresCacheGateway) {
        self.genresListGateway = genresListGateway
        self.genresCacheGateway = genresCacheGateway
    }
    
    func cacheGenresIfNeeded() {
        if getNeedsCache() {
            genresListGateway.fetchGenres { [weak self] result in
                if let genres = result.value {
                    self?.genresCacheGateway.addGenres(genres, { _ in
                        self?.setNeedsCache(false)
                    })
                }
            }
        }
    }
    
    private func getNeedsCache() -> Bool {
        return !UserDefaults.standard.bool(forKey: GenresCacher.cachedGenresKey)
    }
    
    private func setNeedsCache(_ needsCache: Bool) {
        UserDefaults.standard.set(!needsCache, forKey: GenresCacher.cachedGenresKey)
        UserDefaults.standard.synchronize()
    }
}
