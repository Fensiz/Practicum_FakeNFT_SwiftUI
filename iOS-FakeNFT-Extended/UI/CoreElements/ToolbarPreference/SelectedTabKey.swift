//
//  SelectedTabKey.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 12.10.2025.
//

import SwiftUI

struct SelectedTabKey: EnvironmentKey {
	static let defaultValue: Int = 0
}

extension EnvironmentValues {
	var selectedTabIndex: Int {
		get { self[SelectedTabKey.self] }
		set { self[SelectedTabKey.self] = newValue }
	}
}
