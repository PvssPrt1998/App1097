import Foundation
import CoreData


extension CaseCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CaseCD> {
        return NSFetchRequest<CaseCD>(entityName: "CaseCD")
    }

    @NSManaged public var uuid: UUID
    @NSManaged public var image: Data
    @NSManaged public var name: String
    @NSManaged public var quantity: Int32

}

extension CaseCD : Identifiable {

}
