//
//  BackToolbar.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 25.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import SwiftUI

struct BackToolbar: ToolbarContent {
	let action: () -> Void

	var body: some ToolbarContent {
		ToolbarItem(placement: .navigationBarLeading) {
			Button(action: action) {
				Image(.chevronLeft)
					.foregroundStyle(DesignSystem.Color.primary)
			}
		}
	}
}
