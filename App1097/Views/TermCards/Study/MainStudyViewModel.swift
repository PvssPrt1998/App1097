import Foundation

final class MainStudyViewModel: ObservableObject {
    
    let source: Source
    
    @Published var timerValue: Int
    let totalTimer: Int
    
    @Published var end = false
    
    @Published var forLearn: Array<Term> = []
    @Published var learned: Array<Term> = []
    
    var minutesLeft: String {
        let minutes = timerValue / 60
        let string = "\(timerValue / 60)"
        if minutes < 10 {
            return "0" + string
        } else {
            return string
        }
    }
    
    var secondsLeft: String {
        let minutes = timerValue / 60
        let seconds = timerValue - (minutes * 60)
        if seconds < 10 {
            return "0" + "\(seconds)"
        } else {
            return "\(seconds)"
        }
    }
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(source: Source) {
        self.source = source
        self.totalTimer = source.timeValue
        self.timerValue = source.timeValue
        self.forLearn = source.terms.shuffled()
    }
    
    func strokeTimer() {
        if timerValue >= 1 {
            timerValue -= 1
        } else {
            end = true
        }
    }
    
    func repeatSkin() {
        let term = forLearn.removeFirst()
        forLearn.append(term)
    }
    func memorized() {
        if !forLearn.isEmpty {
            var term = forLearn[0]
            forLearn.removeFirst()
            term.learned = true
            learned.append(term)
            source.edit(term)
        }
    }
    
    func favoriteAction() {
        forLearn[0].favourite.toggle()
        source.makeFavorite(forLearn[0])
    }
    
    func repeatGame() {
        end = false
        self.timerValue = source.timeValue
        self.forLearn = source.terms.shuffled()
        learned = []
    }
    
}
