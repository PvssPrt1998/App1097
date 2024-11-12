import Foundation
import Combine

final class InventoryViewModel: ObservableObject {
    
    let source: Source
    
    @Published var skinsCount: Int
    @Published var casesCount: Int
    
    private var skinsCountCancellable: AnyCancellable?
    private var casesCountCancellable: AnyCancellable?
    
    init(source: Source) {
        self.source = source
        
        skinsCount = source.skins.count
        casesCount = source.cases.count
        
        skinsCountCancellable = source.$skins.sink { [weak self] value in
            self?.skinsCount = value.count
        }
        casesCountCancellable = source.$cases.sink { [weak self] value in
            self?.casesCount = value.count
        }
    }
    
    
}
