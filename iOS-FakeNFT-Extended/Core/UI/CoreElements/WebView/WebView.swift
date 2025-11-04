//
//  WebView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 10.10.2025.
//

import SwiftUI

struct WebView: View {
	@Environment(\.dismiss) var dismiss
	let url: URL
	let isAppearenceEnabled: Bool

	init(
		url: URL,
		isAppearenceEnabled: Bool = false
	) {
		self.url = url
		self.isAppearenceEnabled = isAppearenceEnabled
	}

	var body: some View {
		WebViewRepresentable(url: url, isAppearenceEnabled: isAppearenceEnabled)
			.ignoresSafeArea(edges: .bottom)
			.navigationBarBackButtonHidden()
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					Button {
						dismiss()
					} label: {
						Image(.chevronLeft)
							.foregroundStyle(.ypBlack)
					}
				}
			}
	}
}

#Preview {
	NavigationStack {
		WebView(url: URL(string: "https://www.apple.com/")!)
			.navigationTitle("WebView")
			.navigationBarTitleDisplayMode(.inline)
	}
}
