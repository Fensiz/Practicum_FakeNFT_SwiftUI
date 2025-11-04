//
//  CoverType.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 09.10.2025.
//

import SwiftUI

enum Cover: Equatable {
	case dummy
	case deleteConfirmation(
		item: CartItem,
		deleteAction: () -> Void,
		cancelAction: () -> Void
	)
	case urlEditAlert(url: Binding<String>, title: String)

	static func == (lhs: Cover, rhs: Cover) -> Bool {
		switch (lhs, rhs) {
			case (.dummy, .dummy): true
			case (.deleteConfirmation, .deleteConfirmation): true
			case (.urlEditAlert, .urlEditAlert): true
			default: false
		}
	}
}
