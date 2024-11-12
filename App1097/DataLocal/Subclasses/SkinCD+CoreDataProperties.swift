import Foundation
import CoreData


extension SkinCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SkinCD> {
        return NSFetchRequest<SkinCD>(entityName: "SkinCD")
    }

    @NSManaged public var uuid: UUID
    @NSManaged public var image: Data
    @NSManaged public var name: String
    @NSManaged public var quantity: Int32
    @NSManaged public var quality: Int32

}

extension SkinCD : Identifiable {

}
