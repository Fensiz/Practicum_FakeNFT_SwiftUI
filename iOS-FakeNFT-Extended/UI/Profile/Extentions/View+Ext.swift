//
//  View+Ext.swift
//  iOS-FakeNFT-Extended
//
//  Created by Герман on 11.10.2025.
//

import SwiftUI

extension View {
    /// Расширение для применения стилей на вью
    func applyTextInputStyle() -> some View {
        modifier(TextInputStyle())
    }
    /// Для управления навигацией, чтобы прервать переход назад если данные изменены на экране
    func introspectNavigationController(_ callback: @escaping (UINavigationController) -> Void) -> some View {
        background(NavigationControllerIntrospection(callback: callback))
    }
}

// MARK: - UIViewControllerRepresentable
struct NavigationControllerIntrospection: UIViewControllerRepresentable {
    var callback: (UINavigationController) -> Void
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        DispatchQueue.main.async {
            if let navigationController = controller.navigationController {
                callback(navigationController)
            }
        }
        return controller
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
