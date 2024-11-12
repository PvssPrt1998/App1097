import Foundation
import Combine

final class CasesCollectionViewModel: ObservableObject {
    
    let source: Source
    @Published var cases: Array<Case> = []
    
    private var casesCancellable: AnyCancellable?
    
    init(source: Source) {
        self.source = source
        
        self.cases = source.cases
        casesCancellable = source.$cases.sink { [weak self] value in
            self?.cases = value
        }
    }
}
