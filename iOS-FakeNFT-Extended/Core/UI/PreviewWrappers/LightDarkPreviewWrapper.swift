//
//  LightDarkPreviewWrapper.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 05.10.2025.
//

import SwiftUI

struct `LightDarkPreviewWrapper`<Content: View>: View {
	@State private var isDarkMode = false
	let content: () -> Content
	init(@ViewBuilder content: @escaping () -> Content) {
		self.content = content
	}

	var body: some View {
		ZStack {
			VStack {
				Spacer()
				Toggle("Dark Mode", isOn: $isDarkMode)
					.padding()
			}
			VStack {
				content()
			}
		}
		.preferredColorScheme(isDarkMode ? .dark : .light)
	}
}
