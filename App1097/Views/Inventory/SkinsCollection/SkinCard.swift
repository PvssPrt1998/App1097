import SwiftUI

struct SkinCard: View {
    
    let skin: Skin
    let sell: () -> Void
    let add: () -> Void
    let delete: () -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            setImage(skin.image)
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 80)
            Text(skin.name)
                .font(.subheadline.weight(.regular))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Quantity: \(skin.quantity)")
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
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(qualityColor(for: skin.quality), lineWidth: 1)
        )
    }
    
    private func setImage(_ data: Data) -> Image {
        guard let image = UIImage(data: data) else {
            return Image(systemName: "camera.fill")
        }
        return Image(uiImage: image)
    }
    
    func qualityColor(for index: Int) -> Color {
        switch index {
        case 0: return .cConsumerGrade
        case 1: return .cIndustrialGrade
        case 2: return .cMilSpec
        case 3: return .cRestricted
        case 4: return .cClassified
        default: return .cCovert
        }
    }
}

#Preview {
    SkinCard(skin: Skin(uuid: UUID(), image: Data(), name: "Name1", quantity: 30, quality: 4), sell: {}, add: {}, delete: {})
        .padding()
        .background(Color.bgMain)
}
