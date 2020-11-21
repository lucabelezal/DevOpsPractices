import CoreData

extension NSEntityDescription {
    static func insertNewObject<T: NSManagedObject>(
        ofType type: T.Type,
        into context: NSManagedObjectContext
    ) -> T? {
        return insertNewObject(forEntityName: T.entityName, into: context) as? T
    }
}
