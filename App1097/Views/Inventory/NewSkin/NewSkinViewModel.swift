import Foundation

final class NewSkinViewModel: ObservableObject {
    
    let source: Source
    
    var disabled: Bool {
        image == nil || name == "" || quantity == "" || quality == nil
    }
    
    @Published var image: Data?
    @Published var name = ""
    @Published var quantity = ""
    @Published var quality: Int?
    
    init(source: Source) {
        self.source = source
    }
    
    func save() {
        guard let image = image, let quality = quality, let quantity = Int(quantity) else { return }
        source.saveSkin(Skin(uuid: UUID(), image: image, name: name, quantity: quantity, quality: quality))
    }
}


