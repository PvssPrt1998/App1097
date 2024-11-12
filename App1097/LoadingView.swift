import SwiftUI

struct LoadingView: View {
    
    @AppStorage("showOnboarding") var showOnboarding: Bool = true
    
    @State var value: Double = 0
    @Binding var screen: Screen
    let source: Source
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            VStack(spacing: 147) {
                Image("LoadingLogo")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 76)
                VStack(spacing: 12) {
                    Text("\(Int(value * 100))%")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.white.opacity(0.8))
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white.opacity(0.25))
                        .frame(width: 200, height: 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .frame(width: value * 200)
                            ,alignment: .leading
                        )
                }
            }
        }
        .onAppear {
            stroke()
            source.load()
        }
    }
    
    private func stroke() {
        if value < 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
                self.value += 0.02
                self.stroke()
            }
        } else {
            if !source.loaded {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
                    self.stroke()
                }
            } else {
                if showOnboarding {
                    showOnboarding = false
                    screen = .onboarding
                } else {
                    screen = .main
                }
            }
        }
    }
}

struct Splash_Preview: PreviewProvider {
    
    @State static var screen: Screen = .loading
    
    static var previews: some View {
        LoadingView(screen: $screen, source: Source())
    }
}
