import CoreData

extension GenreCoreData {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<GenreCoreData> {
        return NSFetchRequest<GenreCoreData>(entityName: entityName)
    }

    @NSManaged public var id: Int
    @NSManaged public var name: String
    @NSManaged public var movies: NSOrderedSet
}
