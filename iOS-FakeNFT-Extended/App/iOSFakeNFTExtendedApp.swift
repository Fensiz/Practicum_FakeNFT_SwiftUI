import SwiftUI
import SwiftData

@main
struct FakeNFTExtendedApp: App {
	init() {
		let tabAppearance = UITabBarAppearance()
		tabAppearance.configureWithDefaultBackground()
		tabAppearance.backgroundColor = .ypWhite
		tabAppearance.shadowColor = .clear
		UITabBar.appearance().standardAppearance = tabAppearance
		UITabBar.appearance().scrollEdgeAppearance = tabAppearance

		let navAppearance = UINavigationBarAppearance()
		navAppearance.configureWithTransparentBackground()
		navAppearance.backgroundColor = .ypWhite
		UINavigationBar.appearance().standardAppearance = navAppearance
		UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
	}

	var body: some Scene {
		WindowGroup {
			if UIApplication.isRunningTests {
				EmptyView()
			} else {
				ContentView()
			}
		}
	}
}
