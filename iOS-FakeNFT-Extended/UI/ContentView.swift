import SwiftUI

struct ContentView: View {
	var body: some View {
		let coordinator = RootCoordinatorImpl()
		let factory = ViewFactory(rootCoordinator: coordinator)
		TabBarView(
			rootCoordinator: coordinator,
			viewFactory: factory,
			tabs: [.profile, .catalog, .cart]
		)
	}
}
