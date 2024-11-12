import Foundation
import Combine

final class TermCardsViewModel: ObservableObject {
    
    let source: Source
    
    @Published var terms: Array<Term>
    
    var learned: String {
        "\(terms.filter { $0.learned }.count)"
    }
    
    private var termsCancellable: AnyCancellable?
    
    init(source: Source) {
        self.source = source
        self.terms = source.terms
        
        termsCancellable = source.$terms.sink { [weak self] value in
            self?.terms = value
        }
    }
    
    func makeFavorite(_ term: Term) {
        source.makeFavorite(term)
    }
}
