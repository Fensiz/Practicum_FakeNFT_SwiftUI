//
//  WebView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 10.10.2025.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) { }

}

#Preview {
    NavigationStack {
        WebView(url: URL(string: "https://www.apple.com/")!)
            .navigationTitle("WebView")
            .navigationBarTitleDisplayMode(.inline)
    }
}
