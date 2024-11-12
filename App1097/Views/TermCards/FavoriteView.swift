import SwiftUI
import UIKit

struct FavoriteView: View {
    
    @ObservedObject var viewModel = VMCreator.shared.makeFavoriteViewModel()
    @Binding var show: Bool
    @State var showLearn = false
    
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
            
            Button {
                showLearn = true
            } label: {
                Text("Learn terms")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 46)
                    .background(LinearGradient(colors: [.orangeGradient1, .orangeGradient2], startPoint: .top, endPoint: .bottom))
                    .clipShape(.rect(cornerRadius: 12))
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 58)
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .sheet(isPresented: $showLearn, content: {
            StudyView(show: $showLearn)
        })
    }
    
    private var header: some View {
        Text("Favourites")
            .font(.system(size: 15, weight: .bold))
            .foregroundColor(.white)
            .padding(.vertical, 15)
            .frame(maxWidth: .infinity)
            .overlay(
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
                , alignment: .leading
            )
    }
    
    var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(0..<viewModel.terms.count, id: \.self) { index in
                    TermCard(term: viewModel.terms[index], tap: {
                        
                    }, favoriteAction: {
                        viewModel.favoriteToggle(viewModel.terms[index])
                    }, withBorder: index != viewModel.terms.count - 1)
                }
            }
            .padding(.bottom, 112)
            
        }
        .padding(.top, 18)
    }
}

struct FavoriteView_Preview: PreviewProvider {
    
    @State static var show = true
    
    static var previews: some View {
        FavoriteView(show: $show)
    }
}
