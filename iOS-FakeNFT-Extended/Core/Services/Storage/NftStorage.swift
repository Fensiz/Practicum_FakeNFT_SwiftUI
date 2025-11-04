import Foundation
import SwiftData

@MainActor
protocol NftStorage: Sendable {
	func saveNft(_ nft: NFT) async throws
	func getNft(with id: String) async throws -> NFT?
}

class NftStorageImpl: NftStorage {
	private var storage: [String: NFT] = [:]

	func saveNft(_ nft: NFT) async {
		storage[nft.id] = nft
	}

	func getNft(with id: String) async -> NFT? {
		storage[id]
	}
}

final class NftStorageSwiftDataImpl: NftStorage {
	private let context: ModelContext

	init(context: ModelContext) {
		self.context = context
	}

	func saveNft(_ nft: NFT) throws {
		let entity = NFTEntity(
			id: nft.id,
			name: nft.name,
			images: nft.images,
			rating: nft.rating,
			descriptionText: nft.description,
			price: nft.price,
			authorURL: nft.author
		)
		context.insert(entity)
		try context.save()
	}

	func getNft(with id: String) throws -> NFT? {
		let fetchDescriptor = FetchDescriptor<NFTEntity>(predicate: #Predicate { $0.id == id })
		guard let entity = try context.fetch(fetchDescriptor).first else { return nil }

		return NFT(
			id: entity.id,
			name: entity.name,
			images: entity.imageURLs,
			rating: entity.rating,
			description: entity.descriptionText,
			price: entity.price,
			author: entity.author
		)
	}

	func getAll() throws -> [NFT] {
		let fetchDescriptor = FetchDescriptor<NFTEntity>()
		let entities = try context.fetch(fetchDescriptor)
		return entities.map {
			NFT(
				id: $0.id,
				name: $0.name,
				images: $0.imageURLs,
				rating: $0.rating,
				description: $0.descriptionText,
				price: $0.price,
				author: $0.author
			)
		}
	}

	func clear() throws {
		let fetchDescriptor = FetchDescriptor<NFTEntity>()
		let entities = try context.fetch(fetchDescriptor)
		for entity in entities {
			context.delete(entity)
		}
		try context.save()
	}
}
