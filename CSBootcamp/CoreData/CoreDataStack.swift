import CoreData

protocol CoreDataStack {
    var context: NSManagedObjectContext { get }
    func saveContext()
}
