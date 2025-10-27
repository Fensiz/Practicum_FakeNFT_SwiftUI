//
//  CartView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 07.10.2025.
//

import SwiftUI

struct CartView: View {
	@State var viewModel: CartViewModel
	let coordinator: any CartCoordinator

	var body: some View {
		VStack {
			if viewModel.items.isEmpty && !viewModel.isLoading {
				Text("Корзина пуста")
					.font(DesignSystem.Font.bodyBold)
					.foregroundStyle(DesignSystem.Color.textPrimary)
					.frame(maxWidth: .infinity, maxHeight: .infinity)
			} else {
				VStack(spacing: .zero) {
					List {
						ForEach(Array(viewModel.items.enumerated()), id: \.1.id) { index, item in
							CartCell(cartItem: item) {
								coordinator.showDeleteConfirmation(for: item) {
									viewModel.remove(item)
								} cancelAction: {}
							}
							.listRowSeparator(.hidden)
							.listRowInsets(
								EdgeInsets(
									top: DesignSystem.Padding.medium,
									leading: DesignSystem.Padding.medium,
									bottom: DesignSystem.Padding.medium,
									trailing: DesignSystem.Padding.medium
								)
							)
							.listRowBackground(Color.clear)
							.padding(.top, index == .zero ? DesignSystem.Padding.large : .zero)
						}
					}
					.listStyle(.plain)
					if !viewModel.isLoading {
						FooterView(
							totalCount: viewModel.items.count,
							totalPrice: viewModel.total
						) {
							coordinator.openPayScreen(onSuccess: viewModel.clearCart)
						}
						.toolbarPreference(imageName: .sort, action: viewModel.showSortDialog)
					}
				}
			}
		}
		.background(DesignSystem.Color.background, ignoresSafeAreaEdges: .all)
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
		.onAppear(perform: viewModel.onAppear)
		.onDisappear(perform: viewModel.onDisappear)
		.loading(viewModel.isLoading)
	}
}

#Preview {
	NavigationStack {
		TabView {
			let coordinator = MockCartCoordinator.shared
			let service = MockCartService.shared
			let viewModel = CartViewModel(cartService: service)
			CartView(viewModel: viewModel, coordinator: coordinator)
				.tabItem {
					Label("Корзина", image: .cartCross)
				}
		}
	}
}
