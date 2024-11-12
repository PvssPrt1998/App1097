import SwiftUI

struct ContentView: View {
    
    @State var screen: Screen = .loading
    
    var body: some View {
        switch screen {
        case .loading:
            LoadingView(screen: $screen, source: VMCreator.shared.source)
        case .onboarding:
            Onboarding(screen: $screen)
        case .main:
            Tab()
        }
    }
}

#Preview {
    ContentView()
}

enum Screen {
    case loading
    case onboarding
    case main
}
