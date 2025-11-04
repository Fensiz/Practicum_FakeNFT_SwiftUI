//
//  MockData.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 11.10.2025.
//
import Foundation

enum Avatar {
	static let user1 = "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/594.jpg"
	static let user2 = "https://cs13.pikabu.ru/post_img/big/2024/04/24/6/1713950388175292726.png"
	static let user3 = "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/844.jpg"
	static let user4 = "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/991.jpg"
	static let user5 = "https://clck.ru/3DUYFN"
	static let user6 = "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/255.jpg"
	static let user7 = "https://pixelbox.ru/wp-content/uploads/2021/04/ava-mult-vk-49.jpg"
	static let user8 = "https://i.ibb.co/fVLFtWrM/c1f8f42c5f5bd684e27d93131dc6ffd4696cdfd3.jpg"
}

enum Bio {
	static let statisticCard =
  """
  Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT,
  и еще больше — на моём сайте. Открыт к коллаборациям.
  """
}

enum MockNFTIDs {
	static let sample: [String] = [
		"e8c1f0b6-5caf-4f65-8e5b-12f4bcb29efb",
		"b3907b86-37c4-4e15-95bc-7f8147a9a660",
		"d6a02bd1-1255-46cd-815b-656174c1d9c0",
		"f380f245-0264-4b42-8e7e-c4486e237504",
		"de7c0518-6379-443b-a4be-81f5a7655f48",
		"c14cf3bc-7470-4eec-8a42-5eaa65f4053c",
		"b2f44171-7dcd-46d7-a6d3-e2109aacf520",
		"e33e18d5-4fc2-466d-b651-028f78d771b8",
		"db196ee3-07ef-44e7-8ff5-16548fc6f434",
		"82570704-14ac-4679-9436-050f4a32a8a0"
	]

	static func make(_ itemsCount: Int) -> [String] {
		(0..<itemsCount).map { sample[$0 % sample.count] }
	}
}

actor MockNFTItemCollectionService: NFTItemCollectionService {
	func loadNft(id: String) async throws -> NFTItem {
		try await Task.sleep(nanoseconds: 150_000_000) // имитация сети
		let url = URL(string: "https://picsum.photos/seed/\(id.prefix(6))/300")!
		return NFTItem(
			id: id,
			name: "NFT \(id.prefix(4))",
			images: [url],
			rating: Int.random(in: 1...5),
			price: Double.random(in: 0.1...3.0)
		)
	}
}

enum MockNFT {
	static let sampleNFTs: [NFTItem] = [
		NFTItem(
			id: "1",
			name: "Myrna Cervantes",
			images: [
				URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/1.png")!,
				URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/2.png")!,
				URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/3.png")!
			],
			rating: 5,
			price: 39.37
		),
		NFTItem(
			id: "2",
			name: "Cool Art NFT",
			images: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Lucky/1.png")!],
			rating: 4,
			price: 25.99
		),
		NFTItem(
			id: "3",
			name: "Rare Collectible",
			images: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/2.png")!],
			rating: 5,
			price: 99.99
		),
		NFTItem(
			id: "4",
			name: "Digital Masterpiece",
			images: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/3.png")!],
			rating: 3,
			price: 15.50
		),
		NFTItem(
			id: "5",
			name: "Abstract Vision",
			images: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/4.png")!],
			rating: 4,
			price: 45.00
		),
		NFTItem(
			id: "6",
			name: "Future Art",
			images: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/5.png")!],
			rating: 5,
			price: 75.25
		)
	]

	static func make(_ count: Int) -> [NFTItem] {
		Array(sampleNFTs.prefix(count))
	}
}

enum ImageNFT {
	static let demoImageURLs: [URL] =
	[
		"https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/1.png",
		"https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/2.png",
		"https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/3.png",
		"https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/4.png",
		"https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/5.png",
		"https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/6.png"
	]
		.compactMap(URL.init(string:))
}

enum MockWebsiteURL {
	static let url = URL(string: "https://www.apple.com")!
}

enum WebsiteUser {
	static let web1 = "https://practicum.yandex.ru/marketplace-manager/"
	static let web2 = "https://practicum.yandex.ru/android-developer/"
	static let web3 = "https://practicum.yandex.ru/promo/courses/qa-automation-engineer-python"
	static let web4 = "https://practicum.yandex.ru/promo/courses/email-marketing"
	static let web5 = "https://practicum.yandex.ru/graphic-designer/"
	static let web6 = "https://example.com"
	static let web7 = "https://ya.ru"
}

struct MockData {
	static let users: [User] = [
		User(id: "1", name: "Alex", avatar: URL(string: Avatar.user1), nfts: MockNFTIDs.make(72), rating: "5"),
		User(id: "2", name: "Bill", avatar: URL(string: Avatar.user2), nfts: MockNFTIDs.make(98), rating: "4"),
		User(id: "3", name: "Alla", avatar: URL(string: Avatar.user3), nfts: MockNFTIDs.make(112), rating: "3"),
		User(id: "4", name: "Mads", avatar: nil, nfts: MockNFTIDs.make(71), rating: "3"),
		User(id: "5", name: "Timothée", avatar: URL(string: Avatar.user5), nfts: MockNFTIDs.make(51), rating: "2"),
		User(id: "6", name: "Lea", avatar: URL(string: Avatar.user6), nfts: MockNFTIDs.make(23), rating: "2"),
		User(id: "7", name: "Eric", avatar: URL(string: Avatar.user7), nfts: MockNFTIDs.make(11), rating: "1"),
		User(id: "8", name: "Joaquin Phoenix", avatar: URL(string: Avatar.user8), nfts: MockNFTIDs.make(112),
			 rating: "1", description: Bio.statisticCard, website: URL(string: WebsiteUser.web7))
	]

	static let nftCollections: [NFTItem] = MockNFT.sampleNFTs
}
