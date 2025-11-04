//
//  ToolbarButtonDescriptor.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 12.10.2025.
//

import SwiftUI

struct ToolbarButtonDescriptor: Equatable {
	let id: Int
	let imageName: ImageResource
	let action: () -> Void

	static func == (lhs: ToolbarButtonDescriptor, rhs: ToolbarButtonDescriptor) -> Bool {
		lhs.id == rhs.id
	}
}
