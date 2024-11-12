import Foundation
import CoreData


extension TermCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TermCD> {
        return NSFetchRequest<TermCD>(entityName: "TermCD")
    }

    @NSManaged public var uuid: UUID
    @NSManaged public var image: Data
    @NSManaged public var name: String
    @NSManaged public var favorite: Bool
    @NSManaged public var learned: Bool
}

extension TermCD : Identifiable {

}
