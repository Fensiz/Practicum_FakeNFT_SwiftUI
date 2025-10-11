//
//  Screen.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 09.10.2025.
//

enum Screen: Hashable {
	case dummy

	static func == (lhs: Screen, rhs: Screen) -> Bool {
		switch (lhs, rhs) {
			case (.dummy, .dummy):
				true
		}
	}

	func hash(into hasher: inout Hasher) {
		switch self {
			case .dummy:
				hasher.combine(0)
		}
	}
}
