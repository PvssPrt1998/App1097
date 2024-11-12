import Foundation

final class NewCaseViewModel: ObservableObject {
    
    let source: Source
    
    var disabled: Bool {
        image == nil || name == "" || quantity == ""
    }
    
    @Published var image: Data?
    @Published var name = ""
    @Published var quantity = ""
    
    init(source: Source) {
        self.source = source
    }
    
    func save() {
        guard let image = image, let quantity = Int(quantity) else { return }
        source.saveCase(Case(uuid: UUID(), image: image, name: name, quantity: quantity))
    }
}
