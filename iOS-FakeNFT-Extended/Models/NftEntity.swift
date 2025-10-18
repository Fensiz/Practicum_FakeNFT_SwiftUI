//
//  NftEntity.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 17.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import SwiftData
import Foundation

@Model
final class NftEntity {
	@Attribute(.unique) var id: String
	var name: String
	var images: [String]
	var rating: Int
	var descriptionText: String
	var price: Double
	var authorURL: String

	init(
		id: String,
		name: String,
		images: [URL],
		rating: Int,
		descriptionText: String,
		price: Double,
		authorURL: URL
	) {
		self.id = id
		self.name = name
		self.images = images.map { $0.absoluteString }
		self.rating = rating
		self.descriptionText = descriptionText
		self.price = price
		self.authorURL = authorURL.absoluteString
	}

	var imageURLs: [URL] {
		images.compactMap(URL.init(string:))
	}

	var author: URL {
		URL(string: authorURL) ?? URL(string: "https://example.com")!
	}
}
