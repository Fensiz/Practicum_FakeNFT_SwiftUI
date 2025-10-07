import SwiftUI

@main
struct iOS_FakeNFT_ExtendedApp: App {
	init() {
		let appearance = UITabBarAppearance()
		appearance.configureWithDefaultBackground()
		appearance.backgroundColor = .ypWhite
		appearance.shadowColor = .clear
		UITabBar.appearance().standardAppearance = appearance
		UITabBar.appearance().scrollEdgeAppearance = appearance
	}

	var body: some Scene {
		WindowGroup {
			ContentView()
				.environment(ServicesAssembly(networkClient: DefaultNetworkClient(), nftStorage: NftStorageImpl()))
		}
	}
}
