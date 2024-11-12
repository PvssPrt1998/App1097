import Foundation

final class EditTermCardViewModel: ObservableObject {
    
    let source: Source
    
    var disabled: Bool {
        image == nil || name == ""
    }
    
    @Published var image: Data?
    @Published var name: String = ""
    
    init(source: Source) {
        self.source = source
        
        if let term = source.termForEdit {
            image = term.image
            name = term.name
        }
    }
    
    func save() {
        guard let image = image, let termForEdit = source.termForEdit else { return }
        source.edit(Term(uuid: termForEdit.uuid, image: image, name: name, favourite: termForEdit.favourite, learned: termForEdit.learned))
    }
    
    func delete() {
        guard let termForEdit = source.termForEdit else { return }
        source.remove(termForEdit)
    }
}
