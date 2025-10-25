import SwiftUI

struct ContentView: View {
	var body: some View {
		let coordinator = RootCoordinatorImpl()
		let profileViewModel = ProfileViewModel(
			profileService: ProfileServiceImpl(networkClient: DefaultNetworkClient()),
			nftsService: NftServiceImpl(
				networkClient: DefaultNetworkClient(),
				storage: NftStorageImpl()
			)
		)
		// Потом factory
		let factory = ViewFactory(
			rootCoordinator: coordinator,
			profileViewModel: profileViewModel
		)
		
		TabBarView(
			rootCoordinator: coordinator,
			viewFactory: factory,
			tabs: [.profile, .catalog]
		)
		.environmentObject(profileViewModel)
	}
}
