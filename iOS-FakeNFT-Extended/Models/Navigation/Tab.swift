//
//  Tab.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 10.10.2025.
//

import SwiftUI

enum Tab: Identifiable {
	case catalog
	case cart
	case profile
	case statistic

	var id: Self { self }

	var title: String {
		switch self {
			case .catalog: NSLocalizedString("tabCatalog", comment: "")
			case .cart: NSLocalizedString("tabCart", comment: "")
			case .profile: NSLocalizedString("tabProfile", comment: "")
			case .statistic: NSLocalizedString("tabStatistic", comment: "")
		}
	}

	var image: String {
		switch self {
			case .catalog: "catalog"
			case .cart: "cart"
			case .profile: "profile"
			case .statistic: "statistic"
		}
	}
}
