//
//  CoverType.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 09.10.2025.
//

import Foundation

enum Cover: Equatable {
	case dummy

	static func == (lhs: Cover, rhs: Cover) -> Bool {
		switch (lhs, rhs) {
			case (.dummy, .dummy): true
		}
	}
}
