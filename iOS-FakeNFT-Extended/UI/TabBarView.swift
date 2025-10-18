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


import SwiftUI

struct ScrollTrackingView<Content: View>: UIViewControllerRepresentable {
	let content: Content

	init(@ViewBuilder content: () -> Content) {
		self.content = content()
	}

	func makeUIViewController(context: Context) -> UIHostingController<Content> {
		let controller = UIHostingController(rootView: content)

		// когда view загрузится — найдем ScrollView
		DispatchQueue.main.async {
			if let scrollView = controller.view.findScrollView() {
				scrollView.delegate = context.coordinator
			}
		}

		return controller
	}

	func updateUIViewController(_ uiViewController: UIHostingController<Content>, context: Context) {
		uiViewController.rootView = content
	}

	func makeCoordinator() -> Coordinator {
		Coordinator()
	}

	final class Coordinator: NSObject, UIScrollViewDelegate {
		func scrollViewDidScroll(_ scrollView: UIScrollView) {
			guard let navBar = scrollView.findNavBar() else { return }

			let appearance = UINavigationBarAppearance()
			print(scrollView.contentOffset.y)
			if scrollView.contentOffset.y <= 0 {
				// прозрачный
				appearance.configureWithTransparentBackground()
			} else {
				// непрозрачный
				appearance.configureWithDefaultBackground()
				appearance.backgroundColor = .ypWhite
			}

//			navBar.standardAppearance = appearance
			navBar.scrollEdgeAppearance = appearance
		}
	}
}

private extension UIView {
	func findScrollView() -> UIScrollView? {
		if let scroll = self as? UIScrollView {
			return scroll
		}
		for sub in subviews {
			if let found = sub.findScrollView() {
				return found
			}
		}
		return nil
	}

	func findNavBar() -> UINavigationBar? {
		sequence(first: self, next: { $0.superview })
			.compactMap { ($0.next as? UIViewController)?.navigationController?.navigationBar }
			.first
	}
}
