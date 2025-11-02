//
//  StatisticCoordinator.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 26.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//
import SwiftUI

@MainActor
@Observable
final class StatisticCoordinator: RootCoordinator {
    var navigationPath: [Screen] = []
    var activeCover: Cover?

    private var isNavigating = false

    private var rootCoordinator: any RootCoordinator

    var navigationPathBinding: Binding<[Screen]> {
        Binding(
            get: { self.navigationPath },
            set: { self.navigationPath = $0 }
        )
    }

    static let shared: StatisticCoordinator = {
        let root = RootCoordinatorImpl()
        return StatisticCoordinator(rootCoordinator: root)
    }()

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
        navigationPath.append(screen)
        Task {
            try? await Task.sleep(nanoseconds: 300_000_000)
            self.isNavigating = false
        }
    }

    func popToRoot() {
        navigationPath.removeAll()
    }

    func goBack() {
        _ = navigationPath.popLast()
    }
}
