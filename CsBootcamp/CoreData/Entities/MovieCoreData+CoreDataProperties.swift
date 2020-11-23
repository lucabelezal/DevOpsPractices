import CoreData

extension MovieCoreData {
    @nonobjc class func fetchRequest() -> NSFetchRequest<MovieCoreData> {
        return NSFetchRequest<MovieCoreData>(entityName: entityName)
    }

    @NSManaged var id: Int
    @NSManaged var title: String
    @NSManaged var overview: String
    @NSManaged var releaseDate: Date
    @NSManaged var posterPath: String
    @NSManaged var genres: NSOrderedSet
}

extension MovieCoreData {
    @objc(insertObject:inGenresAtIndex:)
    @NSManaged func insertIntoGenres(_ value: GenreCoreData, at idx: Int)

    @objc(removeObjectFromGenresAtIndex:)
    @NSManaged func removeFromGenres(at idx: Int)

    @objc(insertGenres:atIndexes:)
    @NSManaged func insertIntoGenres(_ values: [GenreCoreData], at indexes: NSIndexSet)

    @objc(removeGenresAtIndexes:)
    @NSManaged func removeFromGenres(at indexes: NSIndexSet)

    @objc(replaceObjectInGenresAtIndex:withObject:)
    @NSManaged func replaceGenres(at idx: Int, with value: GenreCoreData)

    @objc(replaceGenresAtIndexes:withGenres:)
    @NSManaged func replaceGenres(at indexes: NSIndexSet, with values: [GenreCoreData])

    @objc(addGenresObject:)
    @NSManaged func addToGenres(_ value: GenreCoreData)

    @objc(removeGenresObject:)
    @NSManaged func removeFromGenres(_ value: GenreCoreData)

    @objc(addGenres:)
    @NSManaged func addToGenres(_ values: NSOrderedSet)

    @objc(removeGenres:)
    @NSManaged func removeFromGenres(_ values: NSOrderedSet)
}
