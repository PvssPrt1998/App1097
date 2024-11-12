import Foundation
import Combine

final class FavoriteViewModel: ObservableObject {
    
    let source: Source
    
    @Published var terms: Array<Term>
    
    init(source: Source) {
        self.source = source
        self.terms = source.terms.filter {$0.favourite}
    }
    
    func favoriteToggle(_ term: Term) {
        guard let index = terms.firstIndex(where: {$0.uuid == term.uuid}) else { return }
        terms[index].favourite.toggle()
        source.makeFavorite(term)
        self.terms = source.terms.filter {$0.favourite}
    }
}
