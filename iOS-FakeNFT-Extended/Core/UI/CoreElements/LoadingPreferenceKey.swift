//
//  LoadingPreferenceKey.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 25.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import SwiftUI

struct LoadingPreferenceKey: PreferenceKey {
	static let defaultValue: Bool = false

	static func reduce(value: inout Bool, nextValue: () -> Bool) {
		value = nextValue() || value
	}
}

extension View {
	func loading(_ isLoading: Bool) -> some View {
		self.preference(key: LoadingPreferenceKey.self, value: isLoading)
	}
}
