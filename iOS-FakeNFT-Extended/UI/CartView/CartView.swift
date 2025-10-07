//
//  CartView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 07.10.2025.
//

import SwiftUI

@MainActor
@Observable
class CartCoordinator {
	let rootCoordinator: any RootCoordinator

	init(rootCoordinator: any RootCoordinator) {
		self.rootCoordinator = rootCoordinator
	}

	func openPayScreen() {
//		rootCoordinator.
	}

	func showDeleteConfirmation(
		for item: CartItem,
		deleteAction: @escaping () -> Void,
		cancelAction: @escaping () -> Void
	) {
//		rootCoordinator.show(cover: .deleteConfirmation(
//			item: item,
//			deleteAction: deleteAction,
//			cancelAction: cancelAction
//		))
	}
}

class MockCartServiceImpl: CartService {
	var items = (1...10).map { _ in
		CartItem(
			image: Image(.mock1),
			name: "April",
			rating: 3,
			price: 1.78
		)
	}

	func fetchItems() -> [CartItem] {
		items
	}

	func remove(_ item: CartItem) {
		items.removeAll(where: { $0.id == item.id })
	}
}

protocol CartService {
	func fetchItems() -> [CartItem]
	func remove(_ item: CartItem)
}

@Observable
final class CartViewModel {
	private let cartService: any CartService
	var items: [CartItem] = []
	var isSortMenuShowing: Bool = false

	var total: Double {
		items.map(\.price).reduce(0, +)
	}

	init(cartService: any CartService) {
		self.cartService = cartService
	}

	func showSortDialog() {
		isSortMenuShowing = true
	}

	func updateItems() {
		items = cartService.fetchItems()
	}

	func remove(_ item: CartItem) {
		cartService.remove(item)
		updateItems()
	}

	func isFirstItem(at index: Int) -> Bool {
		index == 0
	}

	enum SortType {
		case name, price, rating
	}

	func sort(by sortType: SortType) {
		switch sortType {
			case .name:
				items.sort(by: { $0.name < $1.name })
			case .price:
				items.sort(by: { $0.price < $1.price })
			case .rating:
				items.sort(by: { $0.rating < $1.rating })
		}
	}
}

struct CartView: View {
	@State var viewModel: CartViewModel
	@State var coordinator: CartCoordinator

	var body: some View {
		NavigationStack {
			VStack(spacing: 0) {
				List {
					ForEach(Array(viewModel.items.enumerated()), id: \.1.id) { index, item in
						CartCell(removeAction: {
							coordinator.showDeleteConfirmation(for: item) {
								viewModel.remove(item)
							} cancelAction: {

							}
						}, cartItem: item)
						.listRowSeparator(.hidden)
						.listRowInsets(
							EdgeInsets(
								top: 16,
								leading: 16,
								bottom: 16,
								trailing: 16
							)
						)
						.listRowBackground(Color.clear)
						.padding(.top, viewModel.isFirstItem(at: index) ? 20 : 0)
					}
				}
				.listStyle(.plain)
				.toolbar {
					ToolbarItem(placement: .topBarTrailing) {
						Button {
							viewModel.showSortDialog()
						} label: {
							Image(.textLeft)
								.foregroundStyle(.ypBlack)
						}
					}
				}
				FooterView(
					totalCount: viewModel.items.count,
					totalPrice: viewModel.total
				) {
					coordinator.openPayScreen()
				}
			}
			.background(.ypWhite, ignoresSafeAreaEdges: .all)
			.confirmationDialog(
				"Сортировка",
				isPresented: $viewModel.isSortMenuShowing,
				titleVisibility: .visible
			) {
				Button("По цене") {
					viewModel.sort(by: .price)
				}
				Button("По рейтингу") {
					viewModel.sort(by: .rating)
				}
				Button("По названию") {
					viewModel.sort(by: .name)
				}
				Button("Отмена", role: .cancel) {}
			}
		}
		.onAppear {
			viewModel.updateItems()
		}
	}
}

struct FooterView: View {
	let totalCount: Int
	let totalPrice: Double
	let payAction: () -> Void

	var body: some View {
		Color.ypLightGrey
			.frame(height: 76)
			.clipShape(.rect(
				topLeadingRadius: 16,
				bottomLeadingRadius: 0,
				bottomTrailingRadius: 0,
				topTrailingRadius: 16
			))
			.overlay {
				HStack {
					VStack(alignment: .leading) {
						Text("\(totalCount) NFT")
							.font(.system(size: 17, weight: .regular))
							.foregroundStyle(.ypBlack)
							.lineLimit(1)
						HStack(spacing: 0) {
							Text(String(format: "%.2f", totalPrice).replacingOccurrences(of: ".", with: ","))
							Text(" ETH")
						}
						.font(.system(size: 17, weight: .bold))
						.foregroundStyle(.ypUGreen)
						.lineLimit(1)
					}
					.frame(maxWidth: .infinity, alignment: .leading)
					Button {
						payAction()
					} label: {
						Text("К оплате")
							.font(.system(size: 17, weight: .bold))
							.frame(maxWidth: .infinity, maxHeight: .infinity)
							.background(.ypBlack)
					}
					.foregroundStyle(.ypWhite)
					.frame(width: 240, height: 44)
					.clipShape(RoundedRectangle(cornerRadius: 16))
				}
				.padding(.horizontal, 16)
			}
	}
}

#Preview {
	TabView {
		let viewModel = CartViewModel(cartService: MockCartServiceImpl())
		CartView(viewModel: viewModel, coordinator: CartCoordinator(rootCoordinator: RootCoordinatorImpl()))
			.tabItem {
				Label("Корзина", image: .cartCross)
			}
	}
}
