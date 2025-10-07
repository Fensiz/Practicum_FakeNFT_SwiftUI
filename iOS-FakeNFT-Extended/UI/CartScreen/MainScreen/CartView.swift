//
//  CartView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 07.10.2025.
//

import SwiftUI

struct CartView: View {
	@State var viewModel: CartViewModel
	@State var coordinator: any CartCoordinator

	var body: some View {
		Group {
			if viewModel.items.isEmpty {
				Text("У вас еще нет NFT")
					.font(.system(size: 17, weight: .bold))
					.foregroundStyle(.ypBlack)
					.frame(maxWidth: .infinity, maxHeight: .infinity)
			} else {
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

					FooterView(
						totalCount: viewModel.items.count,
						totalPrice: viewModel.total
					) {
						coordinator.openPayScreen(onSuccess: viewModel.clearCart)
					}
				}
				.toolbarPreference(imageName: .sort, action: viewModel.showSortDialog)
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
		.onAppear {
			viewModel.updateItems()
		}
	}
}

#Preview {
	NavigationStack {
		TabView {
			let viewModel = CartViewModel(cartService: MockCartServiceImpl())
			CartView(viewModel: viewModel, coordinator: CartCoordinatorImpl(rootCoordinator: RootCoordinatorImpl()))
				.tabItem {
					Label("Корзина", image: .cartCross)
				}
		}
	}
}
