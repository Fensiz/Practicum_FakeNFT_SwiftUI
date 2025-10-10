//
//  CoverShowerCoordinator.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 09.10.2025.
//

import SwiftUI

@MainActor protocol CoverShowerCoordinator: AnyObject {
	func show(cover type: Cover)
}

protocol RootCoordinator: CoverShowerCoordinator {
	var activeCover: Cover? { get }
	var navigationPath: [Screen] { get set }
	func hideCover()
	func open(screen: Screen)
	func popToRoot()
}

@Observable
class RootCoordinatorImpl: RootCoordinator {
	var navigationPath: [Screen] = []
	var activeCover: Cover?

	func show(cover: Cover) {
		activeCover = cover
	}

	func hideCover() {
		activeCover = nil
	}

	func open(screen: Screen) {
		navigationPath.append(screen)
	}

	func popToRoot() {
		navigationPath.removeAll()
	}
}
