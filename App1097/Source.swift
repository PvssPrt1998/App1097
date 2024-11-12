import Foundation
import SwiftUI
import UIKit

final class Source: ObservableObject {
    
    let lm = LocalManager()
    @AppStorage("fistLoad") var firstLoad = true
    var loaded = false
    
    @Published var skins: Array<Skin> = []
    @Published var cases: Array<Case> = []
    @Published var terms: Array<Term> = []
    @Published var portfolio: Portfolio = Portfolio(covert: 0, classified: 0, restricted: 0, milspec: 0, industrialGrade: 0, consumerGrade: 0)
    
    var skinForAction: Skin?
    var caseForAction: Case?
    var termForEdit: Term?
    var timeValue: Int = 0
    
    func load() {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else { return }
            
            if let skins = try? lm.fetchSkins() {
                self.skins = skins
            }
            if let cases = try? lm.fetchCases() {
                self.cases = cases
            }
            if let portfolio = try? lm.fetchPortfolio() {
                self.portfolio = portfolio
            }
            if firstLoad {
                loadPresets()
            } else {
                if let terms = try? lm.fetchTerms() {
                    self.terms = terms
                }
            }
            
            DispatchQueue.main.async {
                self.loaded = true
            }
        }
    }
    
    func loadPresets() {
        firstLoad = false
        terms.append(contentsOf: presetTerms)
        presetTerms.forEach { term in
            save(term)
        }
    }
    
    var presetTerms: Array<Term> = [
        Term(uuid: UUID(), image: UIImage(named: "deagle1")!.pngData()!, name: "Desert Eagle | Sunset Storm 壱", favourite: false, learned: false),
        Term(uuid: UUID(), image: UIImage(named: "deagle2")!.pngData()!, name: "Desert Eagle | Printstream", favourite: false, learned: false),
        Term(uuid: UUID(), image: UIImage(named: "deagle3")!.pngData()!, name: "Desert Eagle | Crimson Web", favourite: false, learned: false),
        Term(uuid: UUID(), image: UIImage(named: "deagle4")!.pngData()!, name: "Desert Eagle | Heat Treated", favourite: false, learned: false),
        Term(uuid: UUID(), image: UIImage(named: "deagle5")!.pngData()!, name: "Desert Eagle | Blaze", favourite: false, learned: false),
        Term(uuid: UUID(), image: UIImage(named: "usp1")!.pngData()!, name: "USP-S | Kill Confirmed", favourite: false, learned: false),
        Term(uuid: UUID(), image: UIImage(named: "usp2")!.pngData()!, name: "USP-S | Printstream", favourite: false, learned: false),
        Term(uuid: UUID(), image: UIImage(named: "usp3")!.pngData()!, name: "USP-S | Orion", favourite: false, learned: false),
        Term(uuid: UUID(), image: UIImage(named: "usp4")!.pngData()!, name: "USP-S | Neo-Noir", favourite: false, learned: false),
        Term(uuid: UUID(), image: UIImage(named: "usp5")!.pngData()!, name: "USP-S | Cortex", favourite: false, learned: false),
        Term(uuid: UUID(), image: UIImage(named: "ak1")!.pngData()!, name: "AK-47 | Gold Arabesque", favourite: false, learned: false),
        Term(uuid: UUID(), image: UIImage(named: "ak2")!.pngData()!, name: "AK-47 | Fire Serpent", favourite: false, learned: false),
        Term(uuid: UUID(), image: UIImage(named: "ak3")!.pngData()!, name: "AK-47 | Hydroponic", favourite: false, learned: false),
        Term(uuid: UUID(), image: UIImage(named: "ak4")!.pngData()!, name: "AK-47 | B the Monster", favourite: false, learned: false),
        Term(uuid: UUID(), image: UIImage(named: "ak5")!.pngData()!, name: "AK-47 | Vulcan", favourite: false, learned: false),
        Term(uuid: UUID(), image: UIImage(named: "awp1")!.pngData()!, name: "AWP | Dragon Lore", favourite: false, learned: false),
        Term(uuid: UUID(), image: UIImage(named: "awp2")!.pngData()!, name: "AWP | Gungnir", favourite: false, learned: false),
        Term(uuid: UUID(), image: UIImage(named: "awp3")!.pngData()!, name: "AWP | Fade", favourite: false, learned: false),
        Term(uuid: UUID(), image: UIImage(named: "awp4")!.pngData()!, name: "AWP | CMYK", favourite: false, learned: false),
        Term(uuid: UUID(), image: UIImage(named: "awp5")!.pngData()!, name: "AWP | Oni Taiji", favourite: false, learned: false)
    ]
    
    
    
    func saveSkin(_ skin: Skin) {
        skins.append(skin)
        lm.save(skin)
    }
    
    func addSkin(_ skin: Skin, quantity: Int) {
        guard let index = skins.firstIndex(where: {$0.uuid == skin.uuid}) else { return }
        skins[index].quantity += quantity
        lm.edit(skins[index])
    }
    
    func sellSkin(_ skin: Skin, quantity: Int) {
        guard let index = skins.firstIndex(where: {$0.uuid == skin.uuid}) else { return }
        skins[index].quantity -= quantity
        lm.edit(skins[index])
    }
    
    func removeSkin(_ skin: Skin) {
        guard let index = skins.firstIndex(where: {$0.uuid == skin.uuid}) else { return }
        skins.remove(at: index)
        try? lm.remove(skin)
    }
    
    func saveCase(_ caseE: Case) {
        cases.append(caseE)
        lm.save(caseE)
    }
    
    func sellCase(_ caseE: Case, quantity: Int) {
        guard let index = cases.firstIndex(where: {$0.uuid == caseE.uuid}) else { return }
        cases[index].quantity -= quantity
        lm.edit(cases[index])
    }
    
    func addCase(_ caseE: Case, quantity: Int) {
        guard let index = cases.firstIndex(where: {$0.uuid == caseE.uuid}) else { return }
        cases[index].quantity += quantity
        lm.edit(cases[index])
    }
    
    func removeCase(_ caseE: Case) {
        guard let index = cases.firstIndex(where: {$0.uuid == caseE.uuid}) else { return }
        cases.remove(at: index)
        try? lm.remove(caseE)
    }
    
    func save(_ portfolio: Portfolio) {
        self.portfolio = portfolio
        lm.save(portfolio)
    }
    
    func save(_ term: Term) {
        terms.append(term)
        lm.save(term)
    }
    
    func edit(_ term: Term) {
        guard let index = terms.firstIndex(where: {$0.uuid == term.uuid}) else { return }
        terms[index] = term
        lm.edit(term)
    }
    
    func makeFavorite(_ term: Term) {
        guard let index = terms.firstIndex(where: {$0.uuid == term.uuid}) else { return }
        terms[index].favourite.toggle()
        var term1 = term
        term1.favourite.toggle()
        lm.edit(term1)
    }
    
    func remove(_ term: Term) {
        guard let index = terms.firstIndex(where: {$0.uuid == term.uuid}) else { return }
        terms.remove(at: index)
        try? lm.remove(term)
    }
    
    func resetData() {
        skins = []
        cases = []
        terms = []
        portfolio = Portfolio(covert: 0, classified: 0, restricted: 0, milspec: 0, industrialGrade: 0, consumerGrade: 0)
        try? lm.resetData()
    }
}
