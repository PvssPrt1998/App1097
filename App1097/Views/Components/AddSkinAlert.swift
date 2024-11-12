import SwiftUI

struct AddSkinAlert: View {
    
    let isAdd: Bool
    @Binding var text: String
    let action: () -> Void
    let closeAction: () -> Void
    
    var body: some View {
        VStack(spacing: 2) {
            VStack(spacing: 2) {
                Text(isAdd ? "Do you want to add?" : "Are you really going to sell?")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Text(isAdd ? "Specify the quantity you want to add" : "Specify the quantity you want to sell")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                TextField("", text: $text)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.white)
                    .autocorrectionDisabled(true)
                    .accentColor(.white)
                    .onChange(of: text, perform: { newValue in
                        validation(newValue)
                    })
                    .keyboardType(.numberPad)
                    .background(
                        placeholderView()
                    )
                    .padding(.horizontal, 6)
                    .background(Color.black)
                    .clipShape(.rect(cornerRadius: 5))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.c235235245.opacity(0.3), lineWidth: 0.3)
                    )
                    .padding(.top, 14)
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 15, trailing: 16))
            
            VStack(spacing: 0) {
                Button {
                    action()
                    withAnimation {
                        closeAction()
                    }
                } label: {
                    ZStack {
                        Text(isAdd ? "Add" : "Sell")
                            .font(.system(size: 17, weight: .semibold))
                            .gradientForeground(colors: [.orangeGradient1, .orangeGradient2])
                        Rectangle()
                            .fill(.c128128128.opacity(0.7))
                            .frame(height: 0.4)
                            .frame(maxHeight: .infinity, alignment: .top)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                }
                .disabled(text == "")
                .opacity(text == "" ? 0.5 : 1)
                
                Button {
                    withAnimation {
                        closeAction()
                    }
                } label: {
                    ZStack {
                        Text("Close")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.white.opacity(0.7))
                        Rectangle()
                            .fill(.c128128128.opacity(0.7))
                            .frame(height: 0.4)
                            .frame(maxHeight: .infinity, alignment: .top)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top, 19)
        .frame(width: 270, height: 208)
        .background(Color.c373737)
        .clipShape(.rect(cornerRadius: 14))
    }
    
    @ViewBuilder func placeholderView() -> some View {
        Text(text != "" ? "" : "Quantity")
            .font(.system(size: 17, weight: .regular))
            .foregroundColor(.white.opacity(0.4))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func validation(_ newValue: String) {
        let filtered = newValue.filter { Set("0123456789").contains($0) }
        if filtered != "" {
            text = filtered
        } else {
            text = ""
        }
    }
}

struct AddSkinAlert_Preview: PreviewProvider {
    
    @State static var text = ""
    @State static var show = true
    
    static var previews: some View {
        AddSkinAlert(isAdd: true, text: $text) {
            
        } closeAction: {
            
        }
            .padding()
            .background(Color.black.opacity(0.49))
            .background(Color.bgMain)
        
    }
    
}
