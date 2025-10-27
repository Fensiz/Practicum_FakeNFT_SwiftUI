//
//  MockRootCoordinator.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 24.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

final class MockRootCoordinator: RootCoordinator {
	static let shared = MockRootCoordinator()
	var activeCover: Cover?
	var navigationPath: [Screen]

	init(activeCover: Cover? = nil, navigationPath: [Screen] = []) {
		self.activeCover = activeCover
		self.navigationPath = navigationPath
	}

	func hideCover() {

	}

	func open(screen: Screen) {

	}

	func popToRoot() {

	}

	func goBack() {

	}

	func show(cover type: Cover) {

	}
}
