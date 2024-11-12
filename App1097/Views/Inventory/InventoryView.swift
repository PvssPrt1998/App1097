import SwiftUI

struct InventoryView: View {
    
    @ObservedObject var viewModel = VMCreator.shared.makeInventoryViewModel()
    
    @Binding var showShadow: Bool
    
    @State var showNewSkin = false
    @State var showNewCase = false
    
    @Binding var addSkinAlert: Bool
    @Binding var sellSkinAlert: Bool
    @Binding var removeSkinAlert: Bool
    @Binding var addCaseAlert: Bool
    @Binding var sellCaseAlert: Bool
    @Binding var removeCaseAlert: Bool
    
    @State var selection = 0
    
    init(showShadow: Binding<Bool>, 
         addSkinAlert: Binding<Bool>,
         sellSkinAlert: Binding<Bool>,
         removeSkinAlert: Binding<Bool>,
         addCaseAlert: Binding<Bool>,
         sellCaseAlert: Binding<Bool>,
         removeCaseAlert: Binding<Bool>
    ) {
        self._showShadow = showShadow
        self._addSkinAlert = addSkinAlert
        self._sellSkinAlert = sellSkinAlert
        self._removeSkinAlert = removeSkinAlert
        self._addCaseAlert = addCaseAlert
        self._sellCaseAlert = sellCaseAlert
        self._removeCaseAlert = removeCaseAlert
        UIScrollView.appearance().bounces = true
        UISegmentedControl.appearance().selectedSegmentTintColor = .white.withAlphaComponent(0.1)
        UISegmentedControl.appearance().backgroundColor = UIColor(.cTertiary.opacity(0.24))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            
            VStack(spacing: 0) {
                header
                    .padding(.horizontal, 16)
                numberOfElements
                    .padding(.horizontal, 16)
                segmentedControl
                    .padding(.horizontal, 16)
                
                if selection == 0 {
                    SkinsCollectionView(showSell: $sellSkinAlert, showAdd: $addSkinAlert, showRemove: $removeSkinAlert, showShadow: $showShadow)
                        .padding(.top, 23)
                } else {
                    CasesCollectionView(showSell: $sellCaseAlert, showAdd: $addCaseAlert, showRemove: $removeCaseAlert, showShadow: $showShadow)
                        .padding(.top, 23)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            Rectangle()
                .fill(Color.white.opacity(0.15))
                .frame(height: 0.33)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .sheet(isPresented: $showNewSkin, content: {
            NewSkinView(show: $showNewSkin)
        })
        .sheet(isPresented: $showNewCase, content: {
            NewCaseView(show: $showNewCase)
        })
    }
    
    private var header: some View {
        HStack(spacing: 0) {
            Text("Inventory")
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.c252252252)
                .frame(maxWidth: .infinity, alignment: .leading)
            Button {
                if selection == 0 {
                    showNewSkin = true
                } else {
                    showNewCase = true
                }
            } label: {
                Image(systemName: "plus")
                    .font(.title.bold())
                    .foregroundColor(.c252252252)
            }
        }
        .padding(EdgeInsets(top: 46, leading: 0, bottom: 24, trailing: 0))
    }
    
    private var numberOfElements: some View {
        HStack(spacing: 10) {
            VStack(spacing: 16) {
                Text("Total number of skins")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.white.opacity(0.3))
                Text("\(viewModel.skinsCount)")
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
                Text("Total number of cases")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.white.opacity(0.3))
                Text("\(viewModel.casesCount)")
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
    
    private var segmentedControl: some View {
        Picker("",selection: $selection) {
            Text("Useful").tag(0)
            Text("My articles").tag(1)
        }
        .pickerStyle(.segmented)
        .padding(.top, 20)
    }
}

//struct InventoryView_Preview: PreviewProvider {
//    
//    @State static var showShadow = false
//    
//    static var previews: some View {
//        InventoryView(showShadow: $showShadow)
//    }
//}

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(
            LinearGradient(
                colors: colors,
                startPoint: .top,
                endPoint: .bottom)
        )
            .mask(self)
    }
}
