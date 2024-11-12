import SwiftUI
import UIKit

struct NewTermCardView: View {
    
    @ObservedObject var viewModel = VMCreator.shared.makeNewTermCardViewModel()
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
                content
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
    
    private var header: some View {
        Text("Create a term")
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
                    Button {
                        viewModel.save()
                        show = false
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
    
    var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 19) {
                NewTermImageView(imageData: $viewModel.image)
                TextFieldCustom(text: $viewModel.name, prefix: "Name item", placeholder: "Enter")
            }
        }
        .padding(EdgeInsets(top: 21, leading: 20, bottom: 0, trailing: 20))
    }
}

struct NewTermCardView_Preview: PreviewProvider {
    
    @State static var show = true
    
    static var previews: some View {
        NewTermCardView(show: $show)
    }
}