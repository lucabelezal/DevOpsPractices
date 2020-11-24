import CoreData

extension NSManagedObject {
    static var entityName: String {
        return String(describing: self)
    }
}
