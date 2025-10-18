//
//  SwiftDataStack.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 18.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import SwiftData

@MainActor final class SwiftDataStack {
	static let shared = SwiftDataStack()
	static let inMemory = SwiftDataStack(inMemory: true)

	let container: ModelContainer

	private init(inMemory: Bool = false) {
		let schema = Schema([
			NftEntity.self
		])
		let config = ModelConfiguration(
			schema: schema,
			isStoredInMemoryOnly: inMemory
		)

		do {
			container = try ModelContainer(for: schema, configurations: [config])
		} catch {
			fatalError("Could not create ModelContainer: \(error)")
		}
	}
}
