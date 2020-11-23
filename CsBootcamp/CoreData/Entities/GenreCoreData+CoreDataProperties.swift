import CoreData

extension GenreCoreData {
    @nonobjc class func fetchRequest() -> NSFetchRequest<GenreCoreData> {
        return NSFetchRequest<GenreCoreData>(entityName: entityName)
    }

    @NSManaged var id: Int
    @NSManaged var name: String
    @NSManaged var movies: NSOrderedSet
}
