import Foundation
import Combine

final class ProfileViewModel: ObservableObject {
    
    let source: Source
    
    @Published var skins: Array<Skin> = []
    
    @Published var portfolio: Portfolio
    
    private var portfolioCancellable: AnyCancellable?
    private var skinsCancellable: AnyCancellable?
    
    init(source: Source) {
        self.source = source
        self.portfolio = source.portfolio
        self.skins = source.skins
        
        portfolioCancellable = source.$portfolio.sink { [weak self] value in
            self?.portfolio = value
        }
        skinsCancellable = source.$skins.sink { [weak self] value in
            self?.skins = value
        }
    }
}
