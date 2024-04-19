import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    let webView = WKWebView(frame: .zero)

    func makeUIView(context: Context) -> WKWebView {
        webView
    }
    
    func updateUIView(
        _ uiView: WKWebView,
        context: Context
    ) {
        webView.load(
            URLRequest(url: URL(string: "https://yandex.ru/legal/practicum_offer/")!)
        )
    }
}
