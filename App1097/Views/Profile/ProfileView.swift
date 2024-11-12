import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel = VMCreator.shared.makeProfileViewModel()
    
    @State var showEditPortfolio = false
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text("Portfolio")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.c252252252)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    Button {
                        showEditPortfolio = true
                    } label: {
                        Image(systemName: "pencil")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.c252252252)
                    }
                }
                .padding(EdgeInsets(top: 46, leading: 16, bottom: 24, trailing: 16))
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        numberOfElements.padding(.horizontal, 16)
                        percents.padding(.horizontal, 16)
                        
                        Text("Your skins")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 22)
                            .padding(.horizontal, 16)
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 8), GridItem(.flexible())], spacing: 8) {
                            ForEach(viewModel.skins, id: \.self) { skin in
                                SkinSimpleCard(skin: skin)
                            }
                            .clipShape(.rect(cornerRadius: 10))
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                        .padding(.bottom, 8)
                    }
                }
                
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            Rectangle()
                .fill(Color.white.opacity(0.15))
                .frame(height: 0.33)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .sheet(isPresented: $showEditPortfolio, content: {
            EditPortfolioView(show: $showEditPortfolio)
        })
    }
    
    private var numberOfElements: some View {
        HStack(spacing: 10) {
            VStack(spacing: 16) {
                Text("Skins")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.white.opacity(0.3))
                    .padding(.leading, 15)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(viewModel.skins.count)")
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
            VStack(spacing: 16) {
                Text("Favorites")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.white.opacity(0.3))
                    .padding(.leading, 15)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(viewModel.source.terms.filter{$0.favourite}.count)")
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
        }
        .padding(.top, 13)
    }
    
    private var percents: some View {
        VStack(spacing: 17) {
            HStack(spacing: 4) {
                Text("Covert")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                RoundedRectangle(cornerRadius: 100)
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 151,height: 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .fill(Color.cCovert)
                            .frame(width: CGFloat(viewModel.portfolio.covert) / 100 * 151)
                        ,alignment: .leading
                    )
                
                Text("\(viewModel.portfolio.covert)%")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.white.opacity(0.6))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .frame(width: 48)
            }
            HStack(spacing: 4) {
                Text("Classified")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                RoundedRectangle(cornerRadius: 100)
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 151,height: 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .fill(Color.cClassified)
                            .frame(width: CGFloat(viewModel.portfolio.classified) / 100 * 151)
                        ,alignment: .leading
                    )
                
                Text("\(viewModel.portfolio.classified)%")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.white.opacity(0.6))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .frame(width: 48)
            }
            HStack(spacing: 4) {
                Text("Restricted")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                RoundedRectangle(cornerRadius: 100)
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 151,height: 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .fill(Color.cRestricted)
                            .frame(width: CGFloat(viewModel.portfolio.restricted) / 100 * 151)
                        ,alignment: .leading
                    )
                
                Text("\(viewModel.portfolio.restricted)%")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.white.opacity(0.6))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .frame(width: 48)
            }
            HStack(spacing: 4) {
                Text("Mil-Spec")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                RoundedRectangle(cornerRadius: 100)
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 151,height: 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .fill(Color.cMilSpec)
                            .frame(width: CGFloat(viewModel.portfolio.milspec) / 100 * 151)
                        ,alignment: .leading
                    )
                
                Text("\(viewModel.portfolio.milspec)%")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.white.opacity(0.6))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .frame(width: 48)
            }
            HStack(spacing: 4) {
                Text("Industrial Grade")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                RoundedRectangle(cornerRadius: 100)
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 151,height: 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .fill(Color.cIndustrialGrade)
                            .frame(width: CGFloat(viewModel.portfolio.industrialGrade) / 100 * 151)
                        ,alignment: .leading
                    )
                
                Text("\(viewModel.portfolio.industrialGrade)%")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.white.opacity(0.6))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .frame(width: 48)
            }
            HStack(spacing: 4) {
                Text("Consumer Grade")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                RoundedRectangle(cornerRadius: 100)
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 151,height: 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .fill(Color.cConsumerGrade)
                            .frame(width: CGFloat(viewModel.portfolio.consumerGrade) / 100 * 151)
                        ,alignment: .leading
                    )
                
                Text("\(viewModel.portfolio.consumerGrade)%")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.white.opacity(0.6))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .frame(width: 48)
            }
        }
        .padding(.top, 30)
    }
}

#Preview {
    ProfileView()
}
