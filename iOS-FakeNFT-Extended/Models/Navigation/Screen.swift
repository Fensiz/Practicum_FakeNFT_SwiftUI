//
//  Screen.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 09.10.2025.
//

import Foundation

enum Screen: Hashable {
	case dummy
	case payment(coordinator: any CartCoordinator, action: () async throws -> Void)
	case successPayment(action: () -> Void)
	case web(url: URL)

	static func == (lhs: Screen, rhs: Screen) -> Bool {
		switch (lhs, rhs) {
			case (.dummy, .dummy): true
			case (.payment, .payment): true
			case (.web, .web): true
			case (.successPayment, .successPayment): true
			default: false
		}
	}

	func hash(into hasher: inout Hasher) {
		switch self {
			case .dummy:
				hasher.combine(0)
			case .payment:
				hasher.combine(1)
			case .web:
				hasher.combine(2)
			case .successPayment:
				hasher.combine(3)
		}
	}
}
