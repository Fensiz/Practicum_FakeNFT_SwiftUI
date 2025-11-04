//
//  AppError.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 31.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import SwiftUI

struct AppError: Identifiable, Equatable, Sendable {
	typealias Action = @MainActor () -> Void
	let id = UUID()
	let message: String
	let action: (closure: (@Sendable () -> Void), title: String)?
	let dismissAction: (closure: @Sendable  () -> Void, title: String)

	static func == (lhs: AppError, rhs: AppError) -> Bool {
		lhs.id == rhs.id
	}

	static func of(type: AppErrorTypes) -> AppError {
		switch type {
			case let .payment(action, dismiss),
				let .paymentMethodsRecieve(action, dismiss):
				AppError.withAction(
					message: type.message,
					action: action,
					actionTitle: type.actionTitle,
					dismissAction: dismiss,
					dismissTitle: type.dismissTitle
				)
		}
	}

	static func withAction(
		message: String,
		action actionBlock: @escaping @MainActor () async -> Void,
		actionTitle: String,
		dismissAction dismissBlock: @escaping @MainActor () -> Void,
		dismissTitle: String
	) -> AppError {
		var error: AppError! = nil

		error = AppError(
			message: message,
			action: ({ @Sendable in
				Task { @MainActor in
					await actionBlock()
					dismissBlock()
				}
			}, actionTitle)
			,
			dismissAction: ({ @Sendable in
				Task { @MainActor in
					dismissBlock()
				}
			}, dismissTitle)
		)

		return error
	}
}

enum AppErrorTypes {
	typealias Action = @MainActor () -> Void

	case payment(action: Action, dismiss: Action)
	case paymentMethodsRecieve(action: Action, dismiss: Action)

	var message: String {
		switch self {
			case .payment:
				"Не удалось произвести оплату"
			case .paymentMethodsRecieve:
				"Не удалось загрузить методы оплаты"
		}
	}

	var actionTitle: String {
		switch self {
			case .payment, .paymentMethodsRecieve:
				"Повторить"
		}
	}

	var dismissTitle: String {
		switch self {
			case .payment, .paymentMethodsRecieve:
				"Отмена"
		}
	}
}

struct ErrorPreferenceKey: PreferenceKey {
	static let defaultValue: [AppError] = []

	static func reduce(value: inout [AppError], nextValue: () -> [AppError]) {
		value.append(contentsOf: nextValue())
	}
}

extension View {
	func error(_ error: AppError?) -> some View {
		self.preference(key: ErrorPreferenceKey.self, value: error.map { [$0] } ?? [])
	}
}
