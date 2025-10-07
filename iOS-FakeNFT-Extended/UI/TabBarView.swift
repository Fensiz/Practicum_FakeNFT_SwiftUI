import SwiftUI

struct TabBarView: View {
	var body: some View {
		TabView {
			TestCatalogView()
				.tabItem {
					Label(
						NSLocalizedString("Tab.catalog", comment: ""),
						systemImage: "square.stack.3d.up.fill"
					)
				}
				.backgroundStyle(.background)
			let viewModel = CartViewModel(cartService: MockCartServiceImpl())
			CartView(viewModel: viewModel)
				.tabItem {
					Label("Корзина", image: .cartCross)
				}
		}
	}
}
