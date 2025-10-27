//
//  SaveButtonView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Hajime4life on 20.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import SwiftUI

struct SaveButtonView: View {
	let isVisible: Bool
	let onSave: () -> Void
	var body: some View {
		Button(action: onSave) {
			Text("Сохранить")
				.frame(maxWidth: .infinity)
				.font(Font(UIFont.bodyBold))
				.foregroundStyle(.ypWhite)
				.padding(.vertical, 19)
				.padding(.horizontal, 8)
				.background(Color.ypBlack.clipShape(RoundedRectangle(cornerRadius: 16)))
		}
		.padding()
		.opacity(isVisible ? 1 : 0)
	}
}
