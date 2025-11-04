//
//  Screen.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 09.10.2025.
//

import Foundation

enum Screen: Hashable {
	case dummy
	// web
	case web(url: URL, isAppearenceEnabled: Bool = false)
	// profile
	case myNfts
	case favorites(ids: [String], unlikeAction: (String) async -> Void)
	case profileEdit(_ profile: ShortProfileModel, saveAction: (ShortProfileModel) async -> Void, closeAction: () -> Void)
	// catalog
	case collectionDetails(collectionID: NFTCollectionNetworkModel.ID)
	// cart
	case payment(coordinator: any CartCoordinator, action: () async throws -> Void)
	case successPayment(action: () -> Void)
	// stats
    case userCard(user: User)
    case userCollection(nftIDs: [String])

	static func == (lhs: Screen, rhs: Screen) -> Bool {
		switch (lhs, rhs) {
			case (.dummy, .dummy): true
			case (.payment, .payment): true
			case (.web, .web): true
			case (.successPayment, .successPayment): true
			case (.myNfts, .myNfts): true
			case (.favorites, .favorites): true
			case (.profileEdit, .profileEdit): true
			case (.userCard, .userCard): true
			case (.userCollection, .userCollection): true
			case (.collectionDetails, .collectionDetails): true
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
			case .myNfts:
				hasher.combine(4)
			case .favorites:
				hasher.combine(5)
			case .profileEdit:
				hasher.combine(6)
			case .userCard:
				hasher.combine(7)
			case .userCollection:
				hasher.combine(8)
			case.collectionDetails:
				hasher.combine(9)
		}
	}
}
