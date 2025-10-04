import Foundation

@MainActor
protocol NftService {
    func loadNft(id: String) async throws -> Nft
}

@MainActor
final class NftServiceImpl: NftService {

    private let networkClient: any NetworkClient
    private let storage: any NftStorage

    init(networkClient: any NetworkClient, storage: any NftStorage) {
        self.storage = storage
        self.networkClient = networkClient
    }

    func loadNft(id: String) async throws -> Nft {
        if let nft = await storage.getNft(with: id) {
            return nft
        }

        let request = NFTRequest(id: id)
        let nft: Nft = try await networkClient.send(request: request)
        await storage.saveNft(nft)
        return nft
    }
}
