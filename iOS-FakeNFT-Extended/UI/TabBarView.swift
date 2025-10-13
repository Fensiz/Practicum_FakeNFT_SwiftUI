import SwiftUI

struct TabBarView: View {
	@State var rootCoordinator: any RootCoordinator
	@State private var toolbarButtons: [Int: ToolbarButtonDescriptor?] = [:]
	@State private var selectedTab = 0
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
				TabView(selection: $selectedTab) {
					ForEach(Array(tabs.enumerated()), id: \.offset) { index, tab in
						viewFactory.makeTabView(for: tab)
							.tabItem {
								Label(tab.title, image: tab.image)
							}
							.tag(index)
							.backgroundStyle(.ypWhite)
							.environment(\.selectedTabIndex, index)
					}
				}
				.toolbar {
					if let toolBarData = toolbarButtons[selectedTab], let toolBarData {
						ToolbarItem(placement: .topBarTrailing) {
							Button {
								toolBarData.action()
							} label: {
								Image(toolBarData.imageName)
									.foregroundStyle(.ypBlack)
									.background(.ypWhite)
							}
						}
					}
				}
				.navigationDestination(for: Screen.self) { screen in
					viewFactory.makeScreenView(for: screen)
				}
				.onPreferenceChange(ToolbarButtonKey.self) { item in
					toolbarButtons = item
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
