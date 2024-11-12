import Foundation

final class StudyViewModel: ObservableObject {
    
    let source: Source
    
    var disabled: Bool {
        minutes == 0 && seconds == 0
    }

    @Published var minutes: Int = 0
    @Published var seconds: Int = 0
    
    init(source: Source) {
        self.source = source
    }
    
    func setup() {
        source.timeValue = minutes * 60 + seconds
    }
}
