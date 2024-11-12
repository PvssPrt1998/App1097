import Foundation
import Combine

final class SkinsCollectionViewModel: ObservableObject {
    
    let source: Source
    
    @Published var skins: Array<Skin> = []
    
    private var skinsCancellable: AnyCancellable?
    
    init(source: Source) {
        self.source = source
        
        self.skins = source.skins
        skinsCancellable = source.$skins.sink { [weak self] value in
            self?.skins = value
        }
    }
}
