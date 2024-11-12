import Foundation
import CoreData


extension PortfolioCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PortfolioCD> {
        return NSFetchRequest<PortfolioCD>(entityName: "PortfolioCD")
    }

    @NSManaged public var covert: Int32
    @NSManaged public var classified: Int32
    @NSManaged public var restricted: Int32
    @NSManaged public var milspec: Int32
    @NSManaged public var industrialgrade: Int32
    @NSManaged public var consumergrade: Int32

}

extension PortfolioCD : Identifiable {

}
