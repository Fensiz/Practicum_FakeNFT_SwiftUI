//
//  ToolbarButtonKey.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 12.10.2025.
//

import SwiftUI

struct ToolbarButtonKey: PreferenceKey {
	nonisolated(unsafe) static var defaultValue: [Int: ToolbarButtonDescriptor?] = [:]

	static func reduce(value: inout [Int: ToolbarButtonDescriptor?], nextValue: () -> [Int: ToolbarButtonDescriptor?]) {
		let newValue = nextValue()
		for (id, descriptor) in newValue {
			guard let descriptor else { continue }
			value[id] = descriptor
		}
	}
}
