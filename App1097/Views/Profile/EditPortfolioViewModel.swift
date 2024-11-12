import Foundation

final class EditPortfolioViewModel: ObservableObject {
    
    let source: Source
    
    var disabled: Bool {
        covert == "" || classified == "" || restricted == "" || milspec == "" || industrialGrade == "" || consumerGrade == ""
    }
    
    @Published var covert: String = ""
    @Published var classified: String = ""
    @Published var restricted: String = ""
    @Published var milspec: String = ""
    @Published var industrialGrade: String = ""
    @Published var consumerGrade: String = ""
    
    init(source: Source) {
        self.source = source
    }
    
    func save() {
        guard let covert = Int(covert),
              let classified = Int(classified),
              let restricted = Int(restricted),
              let milspec = Int(milspec),
              let industrialGrade = Int(industrialGrade),
              let consumerGrade = Int(consumerGrade)
        else { return }
        let portfolio = Portfolio(covert: min(100,covert),
                                  classified: min(100,classified),
                                  restricted: min(100,restricted),
                                  milspec: min(100,milspec),
                                  industrialGrade: min(100,industrialGrade),
                                  consumerGrade: min(100,consumerGrade))
        source.save(portfolio)
    }
}
