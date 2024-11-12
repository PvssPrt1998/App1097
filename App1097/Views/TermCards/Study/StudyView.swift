import SwiftUI

struct StudyView: View {
    
    @Binding var show: Bool
    
    @ObservedObject var viewModel: StudyViewModel = VMCreator.shared.makeStudyViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.bgMain.ignoresSafeArea()
                VStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 2.5)
                        .fill(Color.c606067.opacity(0.3))
                        .frame(width: 36, height: 5)
                        .padding(.top, 5)
                    header
                        .padding(.horizontal, 8)
                    HStack {
                        Picker("Please choose a color", selection: $viewModel.minutes) {
                            ForEach(0...59, id: \.self) { index in
                                            Text("\(index)")
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .labelsHidden()
                        Picker("Please choose a color", selection: $viewModel.seconds) {
                            ForEach(0...59, id: \.self) { index in
                                            Text("\(index)")
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .labelsHidden()
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
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
                    NavigationLink {
                        nextView
                    } label: {
                        Text("Done")
                            .font(.system(size: 17, weight: .regular))
                            .gradientForeground(colors: [.orangeGradient1, .orangeGradient2])
                    }
                    .disabled(viewModel.disabled)
                    .opacity(viewModel.disabled ? 0.5 : 1)
                    .padding(.horizontal, 8)
                }
                , alignment: .leading
            )
    }
    
    private var nextView: some View {
        viewModel.setup()
        return MainStudyView(show: $show)
    }
}
