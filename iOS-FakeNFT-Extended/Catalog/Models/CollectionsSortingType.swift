//
//  CollectionsSortingType.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vladimir on 03.11.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

enum CollectionsSortingType: Int, CaseIterable, Identifiable {

	var id: Self { self }

	case byTitle
	case bySize

	var sortingRule: (NFTCollectionCardModel, NFTCollectionCardModel) -> Bool {
		switch self {
		case .byTitle:
			{ $0.title < $1.title }
		case .bySize:
			{ $0.nftsCount < $1.nftsCount }
		}
	}

}
