import SwiftUI

struct MainStudyView: View {
    
    @StateObject var viewModel: MainStudyViewModel = VMCreator.shared.makeMainStudyViewModel()
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 2.5)
                    .fill(Color.c606067.opacity(0.3))
                    .frame(width: 36, height: 5)
                    .padding(.top, 5)
                header
                    .padding(.horizontal, 8)
                RoundedRectangle(cornerRadius: 100)
                    .fill(Color.white.opacity(0.15))
                    .frame(width: 300, height: 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .fill(LinearGradient(colors: [.orangeGradient1, .orangeGradient2], startPoint: .top, endPoint: .bottom))
                            .frame(width: CGFloat(viewModel.learned.count) / CGFloat(viewModel.learned.count + viewModel.forLearn.count) * 300)
                        ,alignment: .leading
                    )
                    .padding(.horizontal, 16)
                
                if !viewModel.forLearn.isEmpty && !viewModel.end {
                    termCard()
                        .padding(.top, 22)
                } else {
                    endgame
                }
                
                if !viewModel.forLearn.isEmpty && !viewModel.end {
                    HStack(spacing: 8) {
                        Button {
                            viewModel.repeatSkin()
                        } label: {
                            Text("Repeat")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.orangeGradient1)
                                .frame(maxWidth: .infinity)
                                .frame(height: 46)
                                .background(Color.bgMain)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(LinearGradient(colors: [.orangeGradient1, .orangeGradient2], startPoint: .top, endPoint: .bottom), lineWidth: 1)
                                )
                        }
                        Button {
                            viewModel.memorized()
                        } label: {
                            Text("Memorized")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 46)
                                .background(LinearGradient(colors: [.orangeGradient1, .orangeGradient2], startPoint: .top, endPoint: .bottom))
                                .clipShape(.rect(cornerRadius: 12))
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 30)
                } else {
                    VStack(spacing: 8) {
                        Button {
                            viewModel.repeatGame()
                        } label: {
                            Text("Repeat")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.orangeGradient1)
                                .frame(maxWidth: .infinity)
                                .frame(height: 46)
                                .background(Color.bgMain)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(LinearGradient(colors: [.orangeGradient1, .orangeGradient2], startPoint: .top, endPoint: .bottom), lineWidth: 1)
                                )
                        }
                        Button {
                            show = false
                        } label: {
                            Text("Exit")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 46)
                                .background(LinearGradient(colors: [.orangeGradient1, .orangeGradient2], startPoint: .top, endPoint: .bottom))
                                .clipShape(.rect(cornerRadius: 12))
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 30)
                }
                
                
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .onReceive(viewModel.timer, perform: { _ in
                viewModel.strokeTimer()
            })
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    private var endgame: some View {
        VStack(spacing: 4) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.c2120595)
            Text("The time for study is over")
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.white)
            Text("You can repeat the terms again or return to the main screen")
                .font(.system(size: 13, weight: .regular))
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 16)
        .frame(maxHeight: .infinity)
    }
    
    private func termCard() -> some View {
        VStack(spacing: 10) {
            ZStack {
                setImage(viewModel.forLearn[0].image)
                    .resizable()
                    .scaledToFit()
                    .clipped()
                .frame(width: 358, height: 200)
                .clipShape(.rect(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.25), lineWidth: 1)
                )
                
                Image(systemName: viewModel.forLearn[0].favourite ? "star.fill" : "star")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(viewModel.forLearn[0].favourite ? Color.orangeGradient1 : Color.white.opacity(0.4))
                    .frame(width: 36, height: 36)
                    .background(Color.white.opacity(0.05))
                    .clipShape(.rect(cornerRadius: 8))
                    .onTapGesture {
                        viewModel.favoriteAction()
                    }
                    .padding(8)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            }
            .frame(width: 358, height: 200)
            .padding(.top, 16)
            Text(viewModel.forLearn[0].name)
                .font(.system(size: 28, weight: .regular))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
        
        .frame(maxWidth: .infinity, maxHeight: 470, alignment: .top)
        .background(Color.white.opacity(0.1))
        .clipShape(.rect(cornerRadius: 16))
        .padding(.horizontal, 16)
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    private func setImage(_ data: Data) -> Image {
        guard let image = UIImage(data: data) else {
            return Image(systemName: "camera.fill")
        }
        return Image(uiImage: image)
    }
    
    private var header: some View {
        Text("Study time")
            .font(.system(size: 15, weight: .bold))
            .foregroundColor(.white)
            .padding(.vertical, 15)
            .frame(maxWidth: .infinity)
            .overlay(
                HStack(spacing: 0) {
                    Button {
                        show = false
                    } label: {
                        HStack(spacing: 3) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 17, weight: .semibold))
                                .gradientForeground(colors: [.orangeGradient1, .orangeGradient2])
                            
                            Text("Back")
                                .font(.system(size: 17, weight: .regular))
                                .gradientForeground(colors: [.orangeGradient1, .orangeGradient2])
                        }
                        .padding(.horizontal, 8)
                    }
                    Spacer()
                    Text(viewModel.minutesLeft + ":" + viewModel.secondsLeft)
                        .padding(8)
                        .background(Color.white.opacity(0.1))
                        .clipShape(.rect(cornerRadius: 8))
                    .padding(.horizontal, 8)
                }
                , alignment: .leading
            )
    }
}
