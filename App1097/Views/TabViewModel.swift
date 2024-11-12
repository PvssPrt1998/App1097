import Foundation

final class TabViewModel: ObservableObject {
    
    let source: Source
    
    @Published var alertText: String = ""
    
    init(source: Source) {
        self.source = source
    }
    
    func remove() {
        guard let skinForAction = source.skinForAction else { return }
        source.removeSkin(skinForAction)
    }
    
    func sell() {
        guard let skinForAction = source.skinForAction, let quantity = Int(alertText) else { return }
        let q = skinForAction.quantity
        if q - quantity < 0 {
            source.sellSkin(skinForAction, quantity: q)
        } else {
            source.sellSkin(skinForAction, quantity: quantity)
        }
    }
    
    func add() {
        guard let skinForAction = source.skinForAction, let quantity = Int(alertText) else { return }
        source.addSkin(skinForAction, quantity: quantity)
    }
    
    func addCase() {
        guard let caseForAction = source.caseForAction, let quantity = Int(alertText) else { return }
        source.addCase(caseForAction, quantity: quantity)
    }
    
    func sellCase() {
        guard let caseForAction = source.caseForAction, let quantity = Int(alertText) else { return }
        let q = caseForAction.quantity
        if q - quantity < 0 {
            source.sellCase(caseForAction, quantity: q)
        } else {
            source.sellCase(caseForAction, quantity: quantity)
        }
        
    }
    
    func removeCase() {
        guard let caseForAction = source.caseForAction else { return }
        source.removeCase(caseForAction)
    }
}
