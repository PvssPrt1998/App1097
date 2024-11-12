
import SwiftUI

struct TermCard: View {
    
    let term: Term
    let tap: () -> Void
    let favoriteAction: () -> Void
    let withBorder: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                setImage(term.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 56, height: 56)
                    .background(Color.c313966)
                    .clipShape(.rect(cornerRadius: 8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.white.opacity(0.25), lineWidth: 0.5)
                    )
                
                Text(term.name)
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: term.favourite ? "star.fill" : "star")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(term.favourite ? Color.orangeGradient1 : Color.white.opacity(0.4))
                    .frame(width: 32, height: 32)
                    .onTapGesture {
                        favoriteAction()
                    }
            }
            .padding(.horizontal, 16)
            .frame(height: 72)
            if withBorder {
                Rectangle()
                    .fill(Color.white.opacity(0.25))
                    .frame(height: 0.5)
            }
        }
        .background(Color.bgMain)
        .onTapGesture {
            tap()
        }
    }
    
    private func setImage(_ data: Data) -> Image {
        guard let image = UIImage(data: data) else {
            return Image(systemName: "camera.fill")
        }
        return Image(uiImage: image)
    }
}

#Preview {
    TermCard(term: Term(uuid: UUID(), image: Data(), name: "Name", favourite: false, learned: false), tap: {}, favoriteAction: {}, withBorder: true)
}
