import SwiftUI

struct TermCardsView: View {
    
    @ObservedObject var viewModel = VMCreator.shared.makeTermCardsViewModel()
    
    @State var showNewTerm = false
    @State var editTerm = false
    @State var showFavorite = false
    @State var showLearn = false
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            
            VStack(spacing: 0) {
                header
                    .padding(.horizontal, 16)
                VStack(spacing: 16) {
                    Text("Number of terms learned")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.white.opacity(0.3))
                        .padding(.leading, 15)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(viewModel.learned)
                        .font(.largeTitle.bold())
                        .gradientForeground(colors: [.orangeGradient1, .orangeGradient2])
                }
                .frame(maxWidth: .infinity)
                .frame(height: 114)
                .background(Color.white.opacity(0.1))
                .clipShape(.rect(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.05), lineWidth: 2)
                )
                .padding(.horizontal, 16)
                .padding(.top, 13)
                
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
            .padding(.bottom, 9)
            .frame(maxHeight: .infinity, alignment: .bottom)
            
            Rectangle()
                .fill(Color.white.opacity(0.15))
                .frame(height: 0.33)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .sheet(isPresented: $showNewTerm, content: {
            NewTermCardView(show: $showNewTerm)
        })
        .sheet(isPresented: $showFavorite, content: {
            FavoriteView(show: $showFavorite)
        })
        .sheet(isPresented: $editTerm, content: {
            EditTermView(show: $editTerm)
        })
        .sheet(isPresented: $showLearn, content: {
            StudyView(show: $showLearn)
        })
    }
    
    private var header: some View {
        HStack(spacing: 0) {
            Text("Term cards")
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.c252252252)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 15) {
                Button {
                    showNewTerm = true
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.c252252252)
                }
                Button {
                    showFavorite = true
                } label: {
                    Image(systemName: "star.fill")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.c252252252)
                }
            }
        }
        .padding(EdgeInsets(top: 46, leading: 0, bottom: 24, trailing: 0))
    }
    
    @ViewBuilder private var content: some View {
        if viewModel.terms.isEmpty {
            VStack(spacing: 4) {
                Image("questionmarkWhite")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                Text("No cards")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                Text("Create your first study cards")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding(.top, 78)
        } else {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(0..<viewModel.terms.count, id: \.self) { index in
                        TermCard(term: viewModel.terms[index], tap: {
                            viewModel.source.termForEdit = viewModel.terms[index]
                            editTerm = true
                        }, favoriteAction: {
                            viewModel.makeFavorite(viewModel.terms[index])
                        }, withBorder: index != viewModel.terms.count - 1)
                    }
                }
                .padding(.bottom, 63)
                
            }
            .padding(.top, 13)
        }
        
    }
}

#Preview {
    TermCardsView()
}
