import SwiftUI

struct Tab: View {
    
    @ObservedObject var viewModel = VMCreator.shared.makeTabViewModel()
    @State var selection = 0
    
    @State var showShadow = false
    @State var addSkinAlert = false
    @State var sellSkinAlert = false
    @State var removeSkinAlert = false
    @State var addCaseAlert = false
    @State var sellCaseAlert = false
    @State var removeCaseAlert = false
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(rgbColorCodeRed: 255, green: 255, blue: 255, alpha: 0.3)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(rgbColorCodeRed: 255, green: 255, blue: 255, alpha: 0.3)]

        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(rgbColorCodeRed: 255, green: 108, blue: 0, alpha: 1)
        //UIColor(rgbColorCodeRed: 57, green: 229, blue: 123, alpha: 1)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(rgbColorCodeRed: 255, green: 108, blue: 0, alpha: 1)]
        appearance.backgroundColor = UIColor.bgMain
        appearance.shadowColor = .white.withAlphaComponent(0.15)
        appearance.shadowImage = UIImage(named: "tab-shadow")?.withRenderingMode(.alwaysTemplate)
        UITabBar.appearance().backgroundColor = .bgMain
        UITabBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                InventoryView(showShadow: $showShadow, 
                              addSkinAlert: $addSkinAlert,
                              sellSkinAlert: $sellSkinAlert,
                              removeSkinAlert: $removeSkinAlert,
                              addCaseAlert: $addCaseAlert,
                              sellCaseAlert: $sellCaseAlert,
                              removeCaseAlert: $removeCaseAlert
                )
                    .tabItem { VStack {
                        tabViewImage("briefcase.fill")
                        Text("Inventory") .font(.system(size: 10, weight: .medium))
                    } }
                    .tag(0)
                TermCardsView()
                    .tabItem { VStack {
                        Image(selection == 1 ? "bubblequestionSelected" : "bubblequestion")
                        Text("Term cards") .font(.system(size: 10, weight: .medium))
                    } }
                    .tag(1)
                ProfileView()
                    .tabItem { VStack{
                        tabViewImage("person.fill")
                        Text("Profile")
                            .font(.system(size: 10, weight: .medium))
                    }
                    }
                    .tag(2)
                SettingsView(source: viewModel.source)
                    .tabItem {
                        VStack {
                            tabViewImage("gear")
                            Text("Settings") .font(.system(size: 10, weight: .medium))
                        }
                    }
                    .tag(3)
            }
            
            if showShadow {
                Color.black.opacity(0.49).ignoresSafeArea()
            }
            if addSkinAlert {
                AddSkinAlert(isAdd: true, text: $viewModel.alertText) {
                    viewModel.add()
                    viewModel.alertText = ""
                } closeAction: {
                    withAnimation {
                        showShadow = false
                        addSkinAlert = false
                    }
                }
            }
            
            if sellSkinAlert {
                AddSkinAlert(isAdd: false, text: $viewModel.alertText) {
                    viewModel.sell()
                    viewModel.alertText = ""
                } closeAction: {
                    withAnimation {
                        showShadow = false
                        sellSkinAlert = false
                    }
                }
            }
            if removeSkinAlert {
                RemoveSkinAlert {
                    viewModel.remove()
                } closeAction: {
                    withAnimation {
                        showShadow = false
                        removeSkinAlert = false
                    }
                }
            }
            if addCaseAlert {
                AddSkinAlert(isAdd: true, text: $viewModel.alertText) {
                    viewModel.addCase()
                    viewModel.alertText = ""
                } closeAction: {
                    withAnimation {
                        showShadow = false
                        addCaseAlert = false
                    }
                }
            }
            
            if sellCaseAlert {
                AddSkinAlert(isAdd: false, text: $viewModel.alertText) {
                    viewModel.sellCase()
                    viewModel.alertText = ""
                } closeAction: {
                    withAnimation {
                        showShadow = false
                        sellCaseAlert = false
                    }
                }
            }
            if removeCaseAlert {
                RemoveSkinAlert {
                    viewModel.removeCase()
                } closeAction: {
                    withAnimation {
                        showShadow = false
                        removeCaseAlert = false
                    }
                }
            }
        }
    }
    
    @ViewBuilder func tabViewImage(_ systemName: String) -> some View {
        if #available(iOS 15.0, *) {
            Image(systemName: systemName)
                .font(.system(size: 18, weight: .medium))
                .environment(\.symbolVariants, .none)
        } else {
            Image(systemName: systemName)
                .font(.system(size: 18, weight: .medium))
        }
    }
}

#Preview {
    Tab()
}



extension UIColor {
   convenience init(rgbColorCodeRed red: Int, green: Int, blue: Int, alpha: CGFloat) {

     let redPart: CGFloat = CGFloat(red) / 255
     let greenPart: CGFloat = CGFloat(green) / 255
     let bluePart: CGFloat = CGFloat(blue) / 255

     self.init(red: redPart, green: greenPart, blue: bluePart, alpha: alpha)
   }
}
