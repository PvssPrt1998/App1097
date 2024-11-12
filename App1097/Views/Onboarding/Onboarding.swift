import SwiftUI

struct Onboarding: View {
    
    @State var selection = 0
    @Binding var screen: Screen
    
    var body: some View {
        ZStack {
            ScrollView(.init()) {
                TabView(selection: $selection) {
                    ForEach(0...2, id: \.self) { index in
                        Image("OnboardingBackground\(index + 1)")
                            .resizable()
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                VStack(spacing: 8) {
                    Text(upperText)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    Text(lowerText)
                        .font(.body.weight(.regular))
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 33)
                
                VStack(spacing: 0) {
                    Button {
                        next()
                    } label: {
                        Text("Next")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 46)
                            .background(LinearGradient(colors: [.orangeGradient1, .orangeGradient2], startPoint: .top, endPoint: .bottom))
                            .clipShape(.rect(cornerRadius: 12))
                    }
                    indicator
                }
                .padding(.bottom, 8)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .padding(.horizontal, 16)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .onAppear {
            UIScrollView.appearance().bounces = false
        }
        .onDisappear {
            UIScrollView.appearance().bounces = true
        }
    }
    
    func next() {
        if selection == 0 || selection == 1 {
            withAnimation {
                selection += 1
            }
        } else {
            withAnimation {
                screen = .main
            }
        }
    }
    
    var upperText: String {
        switch selection {
        case 0: return "Keep track of your inventory"
        case 1: return "Memorize all the skins"
        default: return "Update your profile"
        }
    }
    
    var lowerText: String {
        switch selection {
        case 0: return "Any skins and cases for CS GO"
        case 1: return "Learn with our cards or add your own"
        default: return "You certainly have a lot to be proud of"
        }
    }
    
    var indicator: some View {
        HStack(spacing: 8) {
            Circle()
                .fill(selection == 0 ? .white : .white.opacity(0.3))
            Circle()
                .fill(selection == 1 ? .white : .white.opacity(0.3))
            Circle()
                .fill(selection == 2 ? .white : .white.opacity(0.3))
            
        }
        .frame(height: 8)
        .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
        .background(Color.c373737.opacity(0.55))
        .clipShape(.rect(cornerRadius: 50))
        .frame(height: 44)
    }
}

struct Onboarding_Preview: PreviewProvider {
    
    @State static var screen: Screen = .onboarding
    
    static var previews: some View {
        Onboarding(screen: $screen)
    }
}
