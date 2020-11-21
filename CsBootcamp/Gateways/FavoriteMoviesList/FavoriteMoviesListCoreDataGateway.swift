import CoreData

final class FavoriteMoviesListCoreDataGateway: FavoriteMoviesListGateway {
    enum Error: Swift.Error {
        case invalidEntityDescription
        case genresNotFound
    }

    private let coreDataStack: CoreDataStack

    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }

    func toggleMovieFavorite(_ movie: Movie) -> Result<Bool> {
        let checkResult = isMovieFavorite(movie)

        guard case let .success(isFavorite) = checkResult else {
            return checkResult
        }

        let result = setMovie(movie, favorite: !isFavorite)

        switch result {
        case .success:
            return .success(!isFavorite)
        case let .failure(error):
            return .failure(error)
        }
    }

    @discardableResult
    func setMovie(_ movie: Movie, favorite: Bool) -> Result<Void> {
        let result = favorite ?
            addMovie(movie) :
            removeMovie(movie)

        switch result {
        case .success:
            return .success(())
        case let .failure(error):
            return .failure(error)
        }
    }

    private func addMovie(_ movie: Movie) -> Result<Void> {
        guard let movieCoreData = NSEntityDescription.insertNewObject(ofType: MovieCoreData.self, into: coreDataStack.context) else {
            return .failure(Error.invalidEntityDescription)
        }

        let result = fetchGenres(withIds: movie.genreIds)
        guard case let .success(genres) = result else {
            return Result.failure(Error.genresNotFound)
        }

        movieCoreData.id = movie.id
        movieCoreData.title = movie.title
        movieCoreData.overview = movie.overview
        movieCoreData.posterPath = movie.posterPath
        movieCoreData.addToGenres(NSOrderedSet(array: genres))
        movieCoreData.releaseDate = movie.releaseDate

        coreDataStack.saveContext()
        return .success(())
    }

    private func removeMovie(_ movie: Movie) -> Result<Void> {
        let request: NSFetchRequest<MovieCoreData> = MovieCoreData.fetchRequest()
        let predicate = NSPredicate(format: "id = %d", movie.id)
        request.predicate = predicate

        do {
            let moviesCoreData = try coreDataStack.context.fetch(request)
            moviesCoreData.forEach(coreDataStack.context.delete)
            coreDataStack.saveContext()
            return .success(())
        } catch {
            return .failure(error)
        }
    }

    func fetchMovies() -> Result<[Movie]> {
        let request: NSFetchRequest<MovieCoreData> = MovieCoreData.fetchRequest()
        do {
            let moviesCoreData = try coreDataStack.context.fetch(request)

            let movies = moviesCoreData.map { movieCoreData in
                Movie(
                    id: Int(movieCoreData.id),
                    genreIds: movieCoreData.genres.map {
                        genre in
                        (genre as! GenreCoreData).id
                    },
                    title: movieCoreData.title,
                    overview: movieCoreData.overview,
                    releaseDate: movieCoreData.releaseDate,
                    posterPath: movieCoreData.posterPath
                )
            }
            return .success(movies)
        } catch {
            return .failure(error)
        }
    }

    func isMovieFavorite(_ movie: Movie) -> Result<Bool> {
        let request: NSFetchRequest<MovieCoreData> = MovieCoreData.fetchRequest()
        let predicate = NSPredicate(format: "id == %d", movie.id)
        request.predicate = predicate

        do {
            let count = try coreDataStack.context.count(for: request)
            return .success(count > 0)
        } catch {
            return .failure(error)
        }
    }

    private func fetchGenres(withIds ids: [Int]) -> Result<[GenreCoreData]> {
        let request: NSFetchRequest<GenreCoreData> = GenreCoreData.fetchRequest()
        let predicate = NSPredicate(format: "id IN %@", ids)
        request.predicate = predicate

        do {
            let genresCoreData = try coreDataStack.context.fetch(request)
            return .success(genresCoreData)
        } catch {
            return .failure(error)
        }
    }
}
