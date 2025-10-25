import Foundation

protocol NftService: Actor {
	func loadNft(id: String) async throws -> NFT
}

final actor NftServiceImpl: NftService {

	private let networkClient: any NetworkClient
	private let storage: any NftStorage

	init(networkClient: any NetworkClient, storage: any NftStorage) {
		self.storage = storage
		self.networkClient = networkClient
	}

	func loadNft(id: String) async throws -> NFT {
		if let nft = try await storage.getNft(with: id) {
			return nft
		}

		let request = NFTRequest(id: id)
		let nft: NFT = try await networkClient.send(request: request)
		try await storage.saveNft(nft)
		return nft
	}
}
