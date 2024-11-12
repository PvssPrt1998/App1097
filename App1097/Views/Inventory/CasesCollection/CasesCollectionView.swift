import SwiftUI

struct CasesCollectionView: View {
    
    @ObservedObject var viewModel = VMCreator.shared.makeCasesCollectionViewModel()
    @Binding var showSell: Bool
    @Binding var showAdd: Bool
    @Binding var showRemove: Bool
    @Binding var showShadow: Bool
    
    var body: some View {
        if viewModel.cases.isEmpty {
            VStack(spacing: 4) {
                Image("InventoryEmptyCase")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 180)
                Text("Add your first cases")
                    .font(.body.weight(.semibold))
                    .foregroundColor(.white.opacity(0.8))
                Text("You haven't added any of your cases")
                    .font(.subheadline.weight(.regular))
                    .foregroundColor(.white.opacity(0.7))
            }
            .frame(maxHeight: .infinity)
        } else {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 8), GridItem(.flexible())], spacing: 8) {
                    ForEach(viewModel.cases, id: \.self) { caseElement in
                        CaseCard(caseElement: caseElement, sell: {
                            viewModel.source.caseForAction = caseElement
                            withAnimation {
                                showShadow = true
                                showSell = true
                            }
                        }, add: {
                            viewModel.source.caseForAction = caseElement
                            withAnimation {
                                showShadow = true
                                showAdd = true
                            }
                        }, delete: {
                            viewModel.source.caseForAction = caseElement
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

