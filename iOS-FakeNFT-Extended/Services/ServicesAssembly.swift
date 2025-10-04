import Foundation

@Observable
@MainActor
final class ServicesAssembly {

    private let networkClient: any NetworkClient
    private let nftStorage: any NftStorage

    init(
        networkClient: any NetworkClient,
        nftStorage: any NftStorage
    ) {
        self.networkClient = networkClient
        self.nftStorage = nftStorage
    }

    var nftService: any NftService {
        NftServiceImpl(
            networkClient: networkClient,
            storage: nftStorage
        )
    }
}
