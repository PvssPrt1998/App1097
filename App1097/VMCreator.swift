import Foundation

final class VMCreator {
    
    let source: Source = Source()
    
    static let shared = VMCreator()
    
    private init() {}
    
    func makeInventoryViewModel() -> InventoryViewModel {
        InventoryViewModel(source: source)
    }
    
    func makeSkinsCollectionViewModel() -> SkinsCollectionViewModel {
        SkinsCollectionViewModel(source: source)
    }
    
    func makeCasesCollectionViewModel() -> CasesCollectionViewModel {
        CasesCollectionViewModel(source: source)
    }
    
    func makeNewSkinViewModel() -> NewSkinViewModel {
        NewSkinViewModel(source: source)
    }
    
    func makeNewCaseViewModel() -> NewCaseViewModel {
        NewCaseViewModel(source: source)
    }
    
    func makeTabViewModel() -> TabViewModel {
        TabViewModel(source: source)
    }
    
    func makeProfileViewModel() -> ProfileViewModel {
        ProfileViewModel(source: source)
    }
    func makeEditPortfolioViewModel() -> EditPortfolioViewModel {
        EditPortfolioViewModel(source: source)
    }
    func makeTermCardsViewModel() -> TermCardsViewModel {
        TermCardsViewModel(source: source)
    }
    func makeNewTermCardViewModel() -> NewTermCardViewModel {
        NewTermCardViewModel(source: source)
    }
    func makeFavoriteViewModel() -> FavoriteViewModel {
        FavoriteViewModel(source: source)
    }
    func makeEditTermCardViewModel() -> EditTermCardViewModel {
        EditTermCardViewModel(source: source)
    }
    func makeStudyViewModel() -> StudyViewModel {
        StudyViewModel(source: source)
    }
    func makeMainStudyViewModel() -> MainStudyViewModel {
        MainStudyViewModel(source: source)
    }
    
}
