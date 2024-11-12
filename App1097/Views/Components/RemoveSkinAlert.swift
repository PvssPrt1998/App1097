import SwiftUI

struct RemoveSkinAlert: View {

    let action: () -> Void
    let closeAction: () -> Void
    
    var body: some View {
        VStack(spacing: 2) {
            VStack(spacing: 2) {
                Text("Do you really want to delete this?")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Text("This will result in a total loss")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
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
                        Text("Delete")
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
}

struct RemoveSkinAlert_Preview: PreviewProvider {
    
    @State static var text = ""
    @State static var show = true
    
    static var previews: some View {
        RemoveSkinAlert() {
            
        } closeAction: {
            
        }
            .padding()
            .background(Color.black.opacity(0.49))
            .background(Color.bgMain)
        
    }
    
}
