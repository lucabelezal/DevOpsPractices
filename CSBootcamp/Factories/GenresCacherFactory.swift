import Foundation

final class GenresCacherFactory {
    static func make() -> GenresCacher {
        let coreDataStack = DefaultCoreDataStack.shared
        let genresListGateway = GenresListMoyaGateway()
        let genresCacheGateway = GenresCacheCoreDataGateway(coreDataStack: coreDataStack)
        let genresCacher = GenresCacher(
            genresListGateway: genresListGateway,
            genresCacheGateway: genresCacheGateway
        )
        return genresCacher
    }
}
