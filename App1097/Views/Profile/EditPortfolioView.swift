import SwiftUI
import UIKit

struct EditPortfolioView: View {
    
    @ObservedObject var viewModel = VMCreator.shared.makeEditPortfolioViewModel()
    @State var showColorMenu = false
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
        Text("Edit portfolio")
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
                        Text("Save")
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
                TextFieldCustom(text: $viewModel.covert, prefix: "% Covert", placeholder: "Enter")
                    .onChange(of: viewModel.covert, perform: { newValue in
                        covertValidation(newValue)
                    })
                    .keyboardType(.numberPad)
                TextFieldCustom(text: $viewModel.classified, prefix: "% Classified", placeholder: "Enter")
                    .onChange(of: viewModel.classified, perform: { newValue in
                        classifiedValidation(newValue)
                    })
                    .keyboardType(.numberPad)
                TextFieldCustom(text: $viewModel.restricted, prefix: "% Restricted", placeholder: "Enter")
                    .onChange(of: viewModel.restricted, perform: { newValue in
                        restrictedValidation(newValue)
                    })
                    .keyboardType(.numberPad)
                TextFieldCustom(text: $viewModel.milspec, prefix: "% Mil-Spec", placeholder: "Enter")
                    .onChange(of: viewModel.milspec, perform: { newValue in
                        milspecValidation(newValue)
                    })
                    .keyboardType(.numberPad)
                TextFieldCustom(text: $viewModel.industrialGrade, prefix: "% Industrial Grade", placeholder: "Enter")
                    .onChange(of: viewModel.industrialGrade, perform: { newValue in
                        industrialGradeValidation(newValue)
                    })
                    .keyboardType(.numberPad)
                TextFieldCustom(text: $viewModel.consumerGrade, prefix: "% Consumer Grade", placeholder: "Enter")
                    .onChange(of: viewModel.consumerGrade, perform: { newValue in
                        consumerGradeValidation(newValue)
                    })
                    .keyboardType(.numberPad)
                    
            }
        }
        .padding(EdgeInsets(top: 21, leading: 20, bottom: 0, trailing: 20))
    }
    
    func covertValidation(_ newValue: String) {
        let filtered = newValue.filter { Set("0123456789").contains($0) }
        if filtered != "" {
            viewModel.covert = filtered
        } else {
            viewModel.covert = ""
        }
    }
    func classifiedValidation(_ newValue: String) {
        let filtered = newValue.filter { Set("0123456789").contains($0) }
        if filtered != "" {
            viewModel.classified = filtered
        } else {
            viewModel.classified = ""
        }
    }
    func restrictedValidation(_ newValue: String) {
        let filtered = newValue.filter { Set("0123456789").contains($0) }
        if filtered != "" {
            viewModel.restricted = filtered
        } else {
            viewModel.restricted = ""
        }
    }
    func milspecValidation(_ newValue: String) {
        let filtered = newValue.filter { Set("0123456789").contains($0) }
        if filtered != "" {
            viewModel.milspec = filtered
        } else {
            viewModel.milspec = ""
        }
    }
    func industrialGradeValidation(_ newValue: String) {
        let filtered = newValue.filter { Set("0123456789").contains($0) }
        if filtered != "" {
            viewModel.industrialGrade = filtered
        } else {
            viewModel.industrialGrade = ""
        }
    }
    func consumerGradeValidation(_ newValue: String) {
        let filtered = newValue.filter { Set("0123456789").contains($0) }
        if filtered != "" {
            viewModel.consumerGrade = filtered
        } else {
            viewModel.consumerGrade = ""
        }
    }
}

struct EditPortfolioView_Preview: PreviewProvider {
    
    @State static var show = true
    
    static var previews: some View {
        EditPortfolioView(show: $show)
    }
}
