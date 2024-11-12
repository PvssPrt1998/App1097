import SwiftUI
import UIKit

struct NewSkinView: View {
    
    @ObservedObject var viewModel = VMCreator.shared.makeNewSkinViewModel()
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
        Text("New skin")
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
                NewSkinImageView(imageData: $viewModel.image)
                TextFieldCustom(text: $viewModel.name, prefix: "Name", placeholder: "Enter")
                TextFieldCustom(text: $viewModel.quantity, prefix: "Quantity", placeholder: "Enter")
                    .onChange(of: viewModel.quantity, perform: { newValue in
                        validation(newValue)
                    })
                    .keyboardType(.numberPad)
                HStack(spacing: 10) {
                    Text("Quality")
                        .font(.body.weight(.medium))
                        .foregroundColor(.white)
                    Text(qualityText)
                        .font(.body.weight(.regular))
                        .foregroundColor(.white.opacity(qualityText.contains("# Choose") ? 0.4 : 1))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.leading, 15)
                .frame(height: 44)
                .overlay(
                    HStack {
                        if viewModel.quality == nil && !showColorMenu {
                            Circle()
                                .fill(
                                    LinearGradient(colors: [qualityColor(for: 1),qualityColor(for: 3),qualityColor(for: 5)], startPoint: .top, endPoint: .bottom)
                                )
                                .frame(width: 30, height: 30)
                                .overlay(
                                    Circle()
                                        .stroke(Color.c224231237, lineWidth: 2)
                                )
                                .onTapGesture {
                                    if !showColorMenu {
                                        withAnimation {
                                            showColorMenu = true
                                        }
                                    }
                                }
                        }
                        ForEach(0..<pickerColorsIndeces.count, id: \.self) { index in
                            Circle()
                                .fill(qualityColor(for: pickerColorsIndeces[index]))
                                .frame(width: 30, height: 30)
                                .overlay(
                                    Circle()
                                        .stroke(index == pickerColorsIndeces.count - 1 && viewModel.quality != nil ? Color.c224231237 : Color.clear, lineWidth: 2)
                                )
                                .onTapGesture {
                                    if !showColorMenu {
                                        withAnimation {
                                            showColorMenu = true
                                        }
                                    } else {
                                        withAnimation {
                                            viewModel.quality = pickerColorsIndeces[index]
                                            showColorMenu = false
                                        }
                                    }
                                }
                        }
                    }
                        .padding(.trailing, 15)
                    ,alignment: .trailing
                )
                .background(Color.white.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white.opacity(0.05), lineWidth: 1)
                )
                .clipShape(.rect(cornerRadius: 10))
            }
        }
        .padding(EdgeInsets(top: 21, leading: 20, bottom: 0, trailing: 20))
    }
    
    func validation(_ newValue: String) {
        let filtered = newValue.filter { Set("0123456789").contains($0) }
        if filtered != "" {
            viewModel.quantity = filtered
        } else {
            viewModel.quantity = ""
        }
    }
    
    private var circleEmptyFill: LinearGradient {
        if viewModel.quality == nil {
            LinearGradient(colors: [qualityColor(for: 0),qualityColor(for: 3),qualityColor(for: 5)], startPoint: .top, endPoint: .bottom)
        } else {
            LinearGradient(colors: [qualityColor(for: viewModel.quality!)], startPoint: .top, endPoint: .bottom)
        }
    }
    
    private var qualityText: String {
        if showColorMenu {
            return ""
        } else if viewModel.quality == nil {
            return "# Choose"
        } else {
            if let hexStr = qualityColor(for: viewModel.quality!).toHex() {
                return "# " + hexStr
            }
            return "# Choose"
        }
    }
    
    private var pickerColorsIndeces: Array<Int> {
        var array = Array<Int>()
        if viewModel.quality != nil {
            array.append(viewModel.quality!)
        }
        
        if showColorMenu {
            for i in 0...5 {
                if i != viewModel.quality {
                    array.insert(i, at: 0)
                }
            }
        }
        return array
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

struct NewSkinView_Preview: PreviewProvider {
    
    @State static var show = true
    
    static var previews: some View {
        NewSkinView(show: $show)
    }
}

struct MyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(configuration.isPressed ? .blue : .red)
            .background(Color(configuration.isPressed ? .gray : .yellow))
            .opacity(configuration.isPressed ? 1 : 0.75)
            .clipShape(Capsule())
    }
}

extension Color {
    func toHex() -> String? {
       let uic = UIColor(self)
       guard let components = uic.cgColor.components, components.count >= 3 else {
           return nil
       }
       let r = Float(components[0])
       let g = Float(components[1])
       let b = Float(components[2])
       var a = Float(1.0)

       if components.count >= 4 {
           a = Float(components[3])
       }

       if a != Float(1.0) {
           return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
       } else {
           return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
       }
    }
}

