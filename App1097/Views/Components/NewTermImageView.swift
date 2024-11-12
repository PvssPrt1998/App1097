import PhotosUI
import SwiftUI

struct NewTermImageView: View {
   
    @Binding var imageData: Data?
    @State var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        ZStack {
            if let image = image {
                ZStack {
                    image
                        .resizable()
                        .scaledToFill()
                        .clipped()
                }
                .frame(width: 358, height: 200)
                .clipShape(.rect(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.25), lineWidth: 1)
                )
            } else {
                VStack(spacing: 4) {
                    Image(systemName: "photo")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.orangeGradient1)
                    Text("Add Image")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                    Text("Tap to add an image here")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(.white.opacity(0.8))
                }
                .frame(width: 358, height: 200)
                .clipShape(.rect(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(LinearGradient(colors: [.orangeGradient1, .orangeGradient2], startPoint: .top, endPoint: .bottom), style: StrokeStyle(lineWidth: 1, dash: [10]))
                )
            }
        }
        .frame(width: 358, height: 200)
        .clipShape(.rect(cornerRadius: 20))
        .background(Color.bgMain)
        .onTapGesture {
            showingImagePicker = true
        }
        .onChange(of: inputImage) { _ in
            loadImage()
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
                .ignoresSafeArea()
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        imageData = inputImage.pngData()
    }
}
