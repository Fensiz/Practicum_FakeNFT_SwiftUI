import Foundation

struct NFTRequest: NetworkRequest, Sendable {

    let id: String

    var endpoint: URL? {
        var comps = URLComponents(string: RequestConstants.baseURL)
        comps?.path = API.NFT.byId(id)
        return comps?.url
    }
}
