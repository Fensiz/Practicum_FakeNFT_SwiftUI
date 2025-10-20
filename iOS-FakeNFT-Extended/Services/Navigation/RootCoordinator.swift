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
    // MARK: - Props:
	var activeCover: Cover? { get }
	var navigationPath: [Screen] { get set }
    
    // MARK: - Methods:
	func hideCover()
	func open(screen: Screen)
	func popToRoot()
	func goBack()
    
    /// profile edit view
    func showSaveButton()
    func hideSaveButton()
}

@Observable
class RootCoordinatorImpl: RootCoordinator {
    // MARK: - Props:
	var navigationPath: [Screen] = []
	var activeCover: Cover?

    /// Profile Edit View:
    var shouldShowSaveButton = false
    // MARK: - Methods:
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

	func goBack() {
		_ = navigationPath.popLast()
	}
    /// Profile Edit View:
    func showSaveButton() {
        shouldShowSaveButton = true
    }
    func hideSaveButton() {
        shouldShowSaveButton = false
    }
}
