//
//  CartServiceImplTests.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 26.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import XCTest
@testable import iOS_FakeNFT_Extended

@MainActor final class CartServiceImplTests: XCTestCase {
	var network: MockNetworkClient!
	var nftService: MockNftService!
	var sut: CartServiceImpl!

	override func setUp() async throws {
		network = MockNetworkClient()
		nftService = MockNftService()
		sut = CartServiceImpl(networkService: network, nftService: nftService)
	}

	func test_whenFetchOrderItems_thenReturnsMappedCartItems() async throws {
		// Given
		let order = Order(id: "1", nfts: ["id1", "id2"])
		await network.setResult(order)

		let nft1 = NFT(
			id: "id1",
			name: "NFT 1",
			images: [URL(string: "https://image1.ru")!],
			rating: 4,
			description: "desc1",
			price: 10,
			author: URL(string: "https://author1.ru")!
		)
		let nft2 = NFT(
			id: "id2",
			name: "NFT 2",
			images: [URL(string: "https://image2.ru")!],
			rating: 1,
			description: "desc2",
			price: 22,
			author: URL(string: "https://author2.ru")!
		)

		await nftService.setNfts(["id1": nft1, "id2": nft2])

		// When
		let result = try await sut.fetchOrderItems()

		// Then
		XCTAssertEqual(result.count, 2)
		XCTAssertEqual(result.map(\.name), ["NFT 1", "NFT 2"])
		XCTAssertEqual(result.map(\.price), [10, 22])
		let ids = await nftService.loadedIds
		XCTAssertEqual(ids, ["id1", "id2"])
	}

	func test_whenFetchOrderItems_thenSkipsNftsWithoutImages() async throws {
		// Given
		let order = Order(id: "1", nfts: ["id1", "id2"])
		await network.setResult(order)

		let nft1 = NFT(
			id: "id1",
			name: "NFT 1",
			images: [URL(string: "https://image1.ru")!],
			rating: 4,
			description: "desc1",
			price: 10,
			author: URL(string: "https://author1.ru")!
		)
		let nft2 = NFT(
			id: "id2",
			name: "NFT 2",
			images: [],
			rating: 1,
			description: "desc2",
			price: 22,
			author: URL(string: "https://author2.ru")!
		)
		await nftService.setNfts(["id1": nft1, "id2": nft2])

		// When
		let result = try await sut.fetchOrderItems()

		// Then
		XCTAssertEqual(result.count, 1)
		XCTAssertEqual(result.first?.id, "id1")
	}

	func test_whenUpdateOrder_thenSendsPutRequestWithIds() async throws {
		// Given
		let ids = ["a", "b", "c"]
		let order = Order(id: "id", nfts: ids)
		await network.setResult(order)

		// When
		try await sut.updateOrder(with: ids)

		// Then
		let request = await network.lastRequest as? OrdersRequest
		XCTAssertNotNil(request)
		XCTAssertEqual(request?.httpMethod, .put)
		XCTAssertEqual(
			request?.dto,
			("nfts=" + ids.joined(separator: ","))
				.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)?
				.data(using: .utf8)
		)
	}
}
