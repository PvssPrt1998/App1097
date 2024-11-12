import SwiftUI

struct SkinsCollectionView: View {
    
    @ObservedObject var viewModel = VMCreator.shared.makeSkinsCollectionViewModel()
    @Binding var showSell: Bool
    @Binding var showAdd: Bool
    @Binding var showRemove: Bool
    @Binding var showShadow: Bool
    
    var body: some View {
        if viewModel.skins.isEmpty {
            VStack(spacing: 4) {
                Image("InventoryEmpty")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 180)
                Text("Add your first skin")
                    .font(.body.weight(.semibold))
                    .foregroundColor(.white.opacity(0.8))
                Text("You haven't added any of your skins")
                    .font(.subheadline.weight(.regular))
                    .foregroundColor(.white.opacity(0.7))
            }
            .frame(maxHeight: .infinity)
        } else {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 8), GridItem(.flexible())], spacing: 8) {
                    ForEach(viewModel.skins, id: \.self) { skin in
                        SkinCard(skin: skin, sell: {
                            viewModel.source.skinForAction = skin
                            withAnimation {
                                showShadow = true
                                showSell = true
                            }
                        }, add: {
                            viewModel.source.skinForAction = skin
                            withAnimation {
                                showShadow = true
                                showAdd = true
                            }
                        }, delete: {
                            viewModel.source.skinForAction = skin
                            withAnimation {
                                showShadow = true
                                showRemove = true
                            }
                        })
                    }
                    .clipShape(.rect(cornerRadius: 10))
                }
                .padding(.top, 1)
                .padding(.bottom, 8)
               
            }
            .clipShape(.rect(cornerRadius: 10))
            .padding(.horizontal, 16)
        }
    }
}
