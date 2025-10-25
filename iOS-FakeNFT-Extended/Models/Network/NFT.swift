import Foundation

struct NFT: Decodable {
	let id: String
	let name: String
	let images: [URL]
	let rating: Int
	let description: String
	let price: Double
	let author: URL
}
