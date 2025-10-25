//
//  NftEntity+Extention.swift
//  iOS-FakeNFT-Extended
//
//  Created by Hajime4life on 25.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

extension NftEntity {
	convenience init(from nft: Nft) {
		self.init(
			id: nft.id,
			name: nft.name,
			images: nft.images,
			rating: nft.rating,
			descriptionText: nft.description,
			price: nft.price,
			authorURL: nft.author
		)
	}
}
