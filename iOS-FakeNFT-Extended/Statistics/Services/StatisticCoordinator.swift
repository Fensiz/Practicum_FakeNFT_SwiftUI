//
//  StatisticCoordinator.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 26.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//
import SwiftUI
import Observation

@MainActor
@Observable
final class StatisticCoordinator {

	private var isNavigating = false
	
	private let rootCoordinator: any RootCoordinator
	
	var navigationPathBinding: Binding<[Screen]> {
		Binding(
			get: { self.rootCoordinator.navigationPath },
			set: { self.rootCoordinator.navigationPath = $0 }
		)
	}
	
	init(rootCoordinator: any RootCoordinator) {
		self.rootCoordinator = rootCoordinator
	}
	
	func show(cover: Cover) {
		rootCoordinator.show(cover: cover)
	}
	
	func hideCover() {
		rootCoordinator.hideCover()
	}
	
	func open(screen: Screen) {
		guard !isNavigating else { return }
		isNavigating = true
		rootCoordinator.open(screen: screen)
		Task {
			try? await Task.sleep(nanoseconds: 300_000_000)
			self.isNavigating = false
		}
	}
	
	func popToRoot() {
		rootCoordinator.popToRoot()
	}
	
	func goBack() {
		rootCoordinator.goBack()
	}
}
