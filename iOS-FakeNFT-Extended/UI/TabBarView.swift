import SwiftUI

struct TabBarView: View {
	@State var rootCoordinator: any RootCoordinator
	private let viewFactory: ViewFactory
	private let tabs: [Tab]

	init(
		rootCoordinator: any RootCoordinator,
		viewFactory: ViewFactory,
		tabs: [Tab]
	) {
		self.rootCoordinator = rootCoordinator
		self.viewFactory = viewFactory
		self.tabs = tabs
	}

	var body: some View {
		ZStack {
			NavigationStack(path: $rootCoordinator.navigationPath) {
				TabView {
					ForEach(tabs) { tab in
						viewFactory.makeTabView(for: tab)
							.tabItem {
								Label(tab.title, image: tab.image)
							}
							.backgroundStyle(.background)
					}
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
