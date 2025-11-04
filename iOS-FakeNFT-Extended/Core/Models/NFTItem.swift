//
//  NFTItemViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 25.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//
import Foundation

struct NFTItem: Identifiable, Hashable, Sendable, Decodable {
	let id: String
	let name: String
	let images: [URL]
	let rating: Int
	let price: Double
}
