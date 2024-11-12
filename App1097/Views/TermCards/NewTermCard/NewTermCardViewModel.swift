import Foundation

final class NewTermCardViewModel: ObservableObject {
    
    let source: Source
    
    var disabled: Bool {
        image == nil || name == ""
    }
    
    @Published var image: Data?
    @Published var name: String = ""
    
    init(source: Source) {
        self.source = source
    }
    
    func save() {
        guard let image = image else { return }
        source.save(Term(uuid: UUID(), image: image, name: name, favourite: false, learned: false))
    }
}
