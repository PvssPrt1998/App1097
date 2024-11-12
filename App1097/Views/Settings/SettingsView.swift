import SwiftUI
import StoreKit

struct SettingsView: View {
    
    @Environment(\.openURL) var openURL
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            VStack(spacing: 0) {
                Text("Settings")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.c252252252)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 46, leading: 16, bottom: 24, trailing: 16))
                
                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        Button {
                            if let url = URL(string: "https://www.termsfeed.com/live/4458cd89-e512-46d5-9782-2a0fd026fa4d") {
                                openURL(url)
                            }
                        } label: {
                            VStack(spacing: 10) {
                                Image(systemName: "list.bullet.rectangle.portrait.fill")
                                    .font(.system(size: 20, weight: .regular))
                                    .foregroundColor(.c252252252)
                                Text("Usage Policy")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.c252252252)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 142)
                            .background(Color.white.opacity(0.1))
                            .clipShape(.rect(cornerRadius: 20))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white.opacity(0.05), lineWidth: 2)
                            )
                        }
                        Button {
                            actionSheet()
                        } label: {
                            VStack(spacing: 10) {
                                Image(systemName: "square.and.arrow.up.fill")
                                    .font(.system(size: 20, weight: .regular))
                                    .foregroundColor(.c252252252)
                                Text("Share app")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.c252252252)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 142)
                            .background(Color.white.opacity(0.1))
                            .clipShape(.rect(cornerRadius: 20))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white.opacity(0.05), lineWidth: 2)
                            )
                        }
                    }
                    HStack(spacing: 10) {
                        Button {
                            SKStoreReviewController.requestReviewInCurrentScene()
                        } label: {
                            VStack(spacing: 10) {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 20, weight: .regular))
                                    .foregroundColor(.c252252252)
                                Text("Rate app")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.c252252252)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 142)
                            .background(Color.white.opacity(0.1))
                            .clipShape(.rect(cornerRadius: 20))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white.opacity(0.05), lineWidth: 2)
                            )
                        }
                        Button {
                            
                        } label: {
                            VStack(spacing: 10) {
                                Image(systemName: "arrow.counterclockwise")
                                    .font(.system(size: 20, weight: .regular))
                                    .foregroundColor(.c252252252)
                                Text("Reset progress")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.c252252252)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 142)
                            .background(Color.white.opacity(0.1))
                            .clipShape(.rect(cornerRadius: 20))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white.opacity(0.05), lineWidth: 2)
                            )
                        }
                    }
                }
                .padding(EdgeInsets(top: 22, leading: 20, bottom: 0, trailing: 20))
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            Rectangle()
                .fill(Color.white.opacity(0.15))
                .frame(height: 0.33)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
    
    func actionSheet() {
        guard let urlShare = URL(string: "https://apps.apple.com/us/app/forcedropcs-ez/id6738045319")  else { return }
        let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
        if #available(iOS 15.0, *) {
            UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?.rootViewController?
            .present(activityVC, animated: true, completion: nil)
        } else {
            UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
        }
    }
}

#Preview {
    SettingsView()
}

extension SKStoreReviewController {
    public static func requestReviewInCurrentScene() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            DispatchQueue.main.async {
                requestReview(in: scene)
            }
        }
    }
}
