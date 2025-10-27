import XCTest
@testable import iOS_FakeNFT_Extended

@MainActor
class CartViewModelTests: XCTestCase {
	var service: MockCartService!
	var sut: CartViewModel!
	var viewModel: CartViewModel { sut }

	override func setUp() async throws {
		service = MockCartService()
		await service.setItems([.mock1, .mock2])
		sut = CartViewModel(cartService: service)
	}

	func test_whenOnAppearCalls_thenIsLoadingIsTrue() async {
		// Given
		await service.setItems([.mock1])

		// When
		sut.onAppear()

		// Then
		XCTAssertTrue(sut.isLoading)

		try? await Task.sleep(for: .seconds(1))
		XCTAssertFalse(sut.isLoading)
		XCTAssertFalse(sut.items.isEmpty)
	}

	func test_whenOnDisappearCalls_thenCancelsLoadingAndSetsIsLoadingFalse() async {
		// When
		sut.onAppear()
		sut.onDisappear()

		// Then
		XCTAssertFalse(sut.isLoading)
	}

	func test_whenSortCalls_thenItemsBecomeSorted() async {
		// Given
		let items = [
			CartItem(id: "1", name: "B", rating: 3, price: 10),
			CartItem(id: "2", name: "A", rating: 4, price: 5)
		]
		await service.setItems(items)

		// When
		sut.onAppear()
		sut.sort(by: .name)
		try? await Task.sleep(for: .seconds(1))

		// Then
		XCTAssertEqual(sut.items.map(\.name), ["A", "B"])

		// When
		sut.sort(by: .price)
		try? await Task.sleep(for: .seconds(1))

		// Then
		XCTAssertEqual(sut.items.map(\.price), [5, 10])

		// When
		sut.sort(by: .rating)
		try? await Task.sleep(for: .seconds(1))

		// Then
		XCTAssertEqual(sut.items.map(\.rating), [4, 3])
	}

	func test_whenAppearAndLoadItems_thenTotalCalculatesCorrectSum() async {
		// Given
		let items = [
			CartItem(id: "1", name: "A", rating: 3, price: 10),
			CartItem(id: "2", name: "B", rating: 4, price: 20)
		]
		await service.setItems(items)

		// When
		sut.onAppear()
		try? await Task.sleep(for: .seconds(1))

		// Then
		XCTAssertEqual(sut.total, 30)
	}

	func test_whenClearCartCalled_thenServiceReceivesEmptyIds() async throws {
		// When
		try await sut.clearCart()

		// Then
		let ids = await service.updateOrderSendedItemIds
		XCTAssertEqual(ids, [])
	}

	func test_whenRemoveCalled_thenItemIsRemovedAndServiceUpdated() async {
		// Given
		let item1 = CartItem(id: "1", name: "A", rating: 1, price: 10)
		let item2 = CartItem(id: "2", name: "B", rating: 2, price: 20)
		await service.setItems([item1, item2])
		sut.onAppear()
		try? await Task.sleep(for: .seconds(1))

		// When
		sut.remove(item1)
		try? await Task.sleep(for: .seconds(1))

		// Then
		XCTAssertEqual(sut.items, [item2])
		let ids = await service.updateOrderSendedItemIds
		XCTAssertEqual(ids, [item2.id])
	}

	func test_whenShowSortDialogCalled_thenIsSortMenuShowingBecomesTrue() {
		// When
		sut.showSortDialog()

		// Then
		XCTAssertTrue(sut.isSortMenuShowing)
	}

	func test_sortTypePersistsBetweenInstances() async {
		// Given
		let item1 = CartItem(id: "1", name: "A", rating: 1, price: 10)
		let item2 = CartItem(id: "2", name: "B", rating: 4, price: 30)
		let item3 = CartItem(id: "3", name: "D", rating: 0, price: 40)
		let item4 = CartItem(id: "4", name: "C", rating: 2, price: 5)
		await service.setItems([item1, item2, item3, item4])

		for type in CartViewModel.SortType.allCases {
			// When
			viewModel.sort(by: type)

			let sut = CartViewModel(cartService: service)
			sut.onAppear()
			try? await Task.sleep(for: .seconds(1))

			// Then
			switch type {
				case .price:
					XCTAssertEqual(sut.items.map(\.price), [5, 10, 30, 40])
				case .name:
					XCTAssertEqual(sut.items.map(\.name), ["A", "B", "C", "D"])
				case .rating:
					XCTAssertEqual(sut.items.map(\.rating), [4, 2, 1, 0])
			}
		}
	}
}
