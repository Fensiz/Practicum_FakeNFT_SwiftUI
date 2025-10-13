//
//  ToolbarPreferenceModifier.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 12.10.2025.
//

import SwiftUI

struct ToolbarPreferenceModifier: ViewModifier {
	@Environment(\.selectedTabIndex) private var tabIndex
	let imageName: ImageResource
	let action: () -> Void

	func body(content: Content) -> some View {
		let descriptor = ToolbarButtonDescriptor(id: tabIndex, imageName: imageName, action: action)
		content.preference(key: ToolbarButtonKey.self, value: [tabIndex: descriptor])
	}
}

extension View {
	func toolbarPreference(imageName: ImageResource, action: @escaping () -> Void) -> some View {
		modifier(ToolbarPreferenceModifier(imageName: imageName, action: action))
	}
}
