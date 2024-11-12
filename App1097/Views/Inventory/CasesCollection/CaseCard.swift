import SwiftUI

struct CaseCard: View {
    
    let caseElement: Case
    let sell: () -> Void
    let add: () -> Void
    let delete: () -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            setImage(caseElement.image)
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 80)
            Text(caseElement.name)
                .font(.subheadline.weight(.regular))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Quantity: \(caseElement.quantity)")
                .font(.subheadline.weight(.regular))
                .foregroundColor(.white.opacity(0.7))
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 0) {
                Button {
                    sell()
                } label: {
                    Image(systemName: "bag.fill.badge.minus")
                        .font(.headline.weight(.semibold))
                        .scaledToFit()
                        .foregroundColor(.orangeGradient1)
                        .frame(width: 24, height: 24)
                }
                .padding(EdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 8))
                .background(Color.white.opacity(0.1))
                .clipShape(.rect(cornerRadius: 10))
                Button {
                    add()
                } label: {
                    Image(systemName: "cart.fill.badge.plus")
                        .font(.headline.weight(.semibold))
                        .scaledToFit()
                        .foregroundColor(.orangeGradient1)
                        .frame(width: 24, height: 24)
                }
                .padding(EdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 8))
                .background(Color.white.opacity(0.1))
                .clipShape(.rect(cornerRadius: 10))
                .frame(maxWidth: .infinity)
                Button {
                    delete()
                } label: {
                    Image(systemName: "trash.fill")
                        .font(.headline.weight(.semibold))
                        .scaledToFit()
                        .foregroundColor(.orangeGradient1)
                        .frame(width: 24, height: 24)
                }
                .padding(EdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 8))
                .background(Color.white.opacity(0.1))
                .clipShape(.rect(cornerRadius: 10))
            }
        }
        .padding(EdgeInsets(top: 16, leading: 12, bottom: 16, trailing: 12))
        .background(Color.white.opacity(0.1))
        .clipShape(.rect(cornerRadius: 10))
    }
    
    private func setImage(_ data: Data) -> Image {
        guard let image = UIImage(data: data) else {
            return Image(systemName: "camera.fill")
        }
        return Image(uiImage: image)
    }
}

#Preview {
    CaseCard(caseElement: Case(uuid: UUID(), image: Data(), name: "Name", quantity: 10), sell: {}, add: {}, delete: {})
        .padding()
        .background(Color.bgMain)
}
