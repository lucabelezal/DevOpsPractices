import CoreData

extension MovieCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieCoreData> {
        return NSFetchRequest<MovieCoreData>(entityName: entityName)
    }

    @NSManaged public var id: Int
    @NSManaged public var title: String
    @NSManaged public var overview: String
    @NSManaged public var releaseDate: Date
    @NSManaged public var posterPath: String
    @NSManaged public var genres: NSOrderedSet

}

extension MovieCoreData {

    @objc(insertObject:inGenresAtIndex:)
    @NSManaged public func insertIntoGenres(_ value: GenreCoreData, at idx: Int)

    @objc(removeObjectFromGenresAtIndex:)
    @NSManaged public func removeFromGenres(at idx: Int)

    @objc(insertGenres:atIndexes:)
    @NSManaged public func insertIntoGenres(_ values: [GenreCoreData], at indexes: NSIndexSet)

    @objc(removeGenresAtIndexes:)
    @NSManaged public func removeFromGenres(at indexes: NSIndexSet)

    @objc(replaceObjectInGenresAtIndex:withObject:)
    @NSManaged public func replaceGenres(at idx: Int, with value: GenreCoreData)

    @objc(replaceGenresAtIndexes:withGenres:)
    @NSManaged public func replaceGenres(at indexes: NSIndexSet, with values: [GenreCoreData])

    @objc(addGenresObject:)
    @NSManaged public func addToGenres(_ value: GenreCoreData)

    @objc(removeGenresObject:)
    @NSManaged public func removeFromGenres(_ value: GenreCoreData)

    @objc(addGenres:)
    @NSManaged public func addToGenres(_ values: NSOrderedSet)

    @objc(removeGenres:)
    @NSManaged public func removeFromGenres(_ values: NSOrderedSet)

}
