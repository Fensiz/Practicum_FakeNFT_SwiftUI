import Foundation

struct NFT: Decodable, Identifiable {
	let id: String
	let name: String
	let images: [URL]
	let rating: Int
	let description: String
	let price: Double
	let author: URL

	var favoriteModel: FavoriteItem {
		FavoriteItem(image: images.first ?? URL(string: "bad")!, name: name, rating: rating, price: price)
	}
}
