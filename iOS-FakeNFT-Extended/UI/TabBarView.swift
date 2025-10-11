import SwiftUI

struct TabBarView: View {
	@State var rootCoordinator: any RootCoordinator
	private let viewFactory: ViewFactory

	init(rootCoordinator: any RootCoordinator, viewFactory: ViewFactory) {
		self.rootCoordinator = rootCoordinator
		self.viewFactory = viewFactory
	}

	var body: some View {
		ZStack {
			NavigationStack(path: $rootCoordinator.navigationPath) {
				TabView {
					TestCatalogView()
						.tabItem {
							Label(
								NSLocalizedString("Tab.catalog", comment: ""),
								systemImage: "square.stack.3d.up.fill"
							)
						}
						.backgroundStyle(.background)
				}
				.navigationDestination(for: Screen.self) { screen in
					viewFactory.makeScreenView(for: screen)
				}
			}
			if let cover = rootCoordinator.activeCover {
				viewFactory.makeCoverView(for: cover)
					.transition(.opacity)
					.zIndex(1)
			}
		}
		.animation(.easeInOut, value: rootCoordinator.activeCover)
	}
}
