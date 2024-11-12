import Foundation


final class LocalManager {
    private let modelName = "CSModel"
    
    lazy var coreDataStack = CoreDataStack(modelName: modelName)
    
    func save(_ skin: Skin) {
        let skinCD = SkinCD(context: coreDataStack.managedContext)
        skinCD.uuid = skin.uuid
        skinCD.image = skin.image
        skinCD.name = skin.name
        skinCD.quantity = Int32(skin.quantity)
        skinCD.quality = Int32(skin.quality)
        coreDataStack.saveContext()
    }
    
    func edit(_ skin: Skin) {
        do {
            let skinsCD = try coreDataStack.managedContext.fetch(SkinCD.fetchRequest())
            skinsCD.forEach { skinCD in
                if skinCD.uuid == skin.uuid {
                    skinCD.quantity = Int32(skin.quantity)
                }
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func remove(_ skin: Skin) throws {
        let skinsCD = try coreDataStack.managedContext.fetch(SkinCD.fetchRequest())
        guard let skinCD = skinsCD.first(where: {$0.uuid == skin.uuid}) else { return }
        coreDataStack.managedContext.delete(skinCD)
        coreDataStack.saveContext()
    }
    
    func fetchSkins() throws -> Array<Skin> {
        var array = Array<Skin>()
        let skinsCD = try coreDataStack.managedContext.fetch(SkinCD.fetchRequest())
        skinsCD.forEach { skinCD in
            array.append(Skin(uuid: skinCD.uuid, image: skinCD.image, name: skinCD.name, quantity: Int(skinCD.quantity), quality: Int(skinCD.quality)))
        }
        return array
    }
    
    func save(_ caseE: Case) {
        let caseCD = CaseCD(context: coreDataStack.managedContext)
        caseCD.uuid = caseE.uuid
        caseCD.image = caseE.image
        caseCD.name = caseE.name
        caseCD.quantity = Int32(caseE.quantity)
        coreDataStack.saveContext()
    }
    
    func edit(_ caseE: Case) {
        do {
            let casesCD = try coreDataStack.managedContext.fetch(CaseCD.fetchRequest())
            casesCD.forEach { caseCD in
                if caseCD.uuid == caseE.uuid {
                    caseCD.quantity = Int32(caseE.quantity)
                }
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func remove(_ caseE: Case) throws {
        let casesCD = try coreDataStack.managedContext.fetch(CaseCD.fetchRequest())
        guard let caseCD = casesCD.first(where: {$0.uuid == caseE.uuid}) else { return }
        coreDataStack.managedContext.delete(caseCD)
        coreDataStack.saveContext()
    }
    
    func fetchCases() throws -> Array<Case> {
        var array = Array<Case>()
        let casesCD = try coreDataStack.managedContext.fetch(CaseCD.fetchRequest())
        casesCD.forEach { caseCD in
            array.append(Case(uuid: caseCD.uuid, image: caseCD.image, name: caseCD.name, quantity: Int(caseCD.quantity)))
        }
        return array
    }
    
    func save(_ portfolio: Portfolio) {
        do {
            let portfolios = try coreDataStack.managedContext.fetch(PortfolioCD.fetchRequest())
            if portfolios.count > 0 {
                //exists
                portfolios[0].covert = Int32(portfolio.covert)
                portfolios[0].classified = Int32(portfolio.classified)
                portfolios[0].consumergrade = Int32(portfolio.consumerGrade)
                portfolios[0].industrialgrade = Int32(portfolio.industrialGrade)
                portfolios[0].milspec = Int32(portfolio.milspec)
                portfolios[0].restricted = Int32(portfolio.restricted)
            } else {
                let portfolioCD =  PortfolioCD(context: coreDataStack.managedContext)
                portfolioCD.covert = Int32(portfolio.covert)
                portfolioCD.classified = Int32(portfolio.classified)
                portfolioCD.consumergrade = Int32(portfolio.consumerGrade)
                portfolioCD.industrialgrade = Int32(portfolio.industrialGrade)
                portfolioCD.milspec = Int32(portfolio.milspec)
                portfolioCD.restricted = Int32(portfolio.restricted)
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func fetchPortfolio() throws -> Portfolio? {
        guard let portfolioCD = try coreDataStack.managedContext.fetch(PortfolioCD.fetchRequest()).first else { return nil }
        return Portfolio(covert: Int(portfolioCD.covert),
                         classified: Int(portfolioCD.classified),
                         restricted: Int(portfolioCD.restricted),
                         milspec: Int(portfolioCD.milspec),
                         industrialGrade: Int(portfolioCD.industrialgrade),
                         consumerGrade: Int(portfolioCD.consumergrade))
    }
    
    func save(_ term: Term) {
        let termCD = TermCD(context: coreDataStack.managedContext)
        termCD.favorite = term.favourite
        termCD.image = term.image
        termCD.name = term.name
        termCD.uuid = term.uuid
        termCD.learned = term.learned
        coreDataStack.saveContext()
    }
    func fetchTerms() throws -> Array<Term> {
        var array: Array<Term> = []
        let termsCD = try coreDataStack.managedContext.fetch(TermCD.fetchRequest())
        termsCD.forEach { termCD in
            array.append(Term(uuid: termCD.uuid, image: termCD.image, name: termCD.name, favourite: termCD.favorite, learned: termCD.learned))
        }
        return array
    }
    func edit(_ term: Term) {
        do {
            let termsCD = try coreDataStack.managedContext.fetch(TermCD.fetchRequest())
            termsCD.forEach { termCD in
                if termCD.uuid == term.uuid {
                    termCD.image = term.image
                    termCD.name = term.name
                    termCD.favorite = term.favourite
                    termCD.learned = term.learned
                }
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    func remove(_ term: Term) throws {
        let termsCD = try coreDataStack.managedContext.fetch(TermCD.fetchRequest())
        guard let termCD = termsCD.first(where: {$0.uuid == term.uuid}) else { return }
        coreDataStack.managedContext.delete(termCD)
        coreDataStack.saveContext()
    }
    
    func resetData() throws {
        let termsCD = try coreDataStack.managedContext.fetch(TermCD.fetchRequest())
        termsCD.forEach { termCD in
            coreDataStack.managedContext.delete(termCD)
        }
        let casesCD = try coreDataStack.managedContext.fetch(CaseCD.fetchRequest())
        casesCD.forEach { caseCD in
            coreDataStack.managedContext.delete(caseCD)
        }
        let skinsCD = try coreDataStack.managedContext.fetch(SkinCD.fetchRequest())
        skinsCD.forEach { skinCD in
            coreDataStack.managedContext.delete(skinCD)
        }
        let portfolios = try coreDataStack.managedContext.fetch(PortfolioCD.fetchRequest())
        portfolios.forEach { port in
            coreDataStack.managedContext.delete(port)
        }
        coreDataStack.saveContext()
    }
}
