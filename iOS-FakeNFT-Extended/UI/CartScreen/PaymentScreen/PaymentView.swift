//
//  PaymentView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 10.10.2025.
//

import SwiftUI

struct PaymentView: View {
	@State var viewModel: PaymentViewModel
	let coordinator: any CartCoordinator
	private let columns = [
		GridItem(.flexible(), spacing: DesignSystem.Spacing.small2),
		GridItem(.flexible(), spacing: DesignSystem.Spacing.small2)
	]

	var body: some View {
		ZStack {
			DesignSystem.Color.background.ignoresSafeArea()
			if !viewModel.isLoading {
				VStack {
					PaymentMethodsGrid(
						methods: viewModel.paymentMethods,
						selectedMethod: viewModel.selectedMethod,
						onSelect: viewModel.select
					)
					Spacer()
					PaymentFooterView(
						isButtonDisabled: viewModel.isButtonDisabled,
						onPay: {
							viewModel.pay {
								coordinator.openSuccessPaymentScreen()
							}
						},
						onUserAgreement: coordinator.openUserAgreementScreen
					)
				}
			}
		}
		.navigationTitle("Выберите способ оплаты")
		.navigationBarTitleDisplayMode(.inline)
		.navigationBarBackButtonHidden(true)
		.toolbar {
			BackToolbar(action: coordinator.goBack)
		}
		.alert(
			"Не удалось произвести оплату",
			isPresented: $viewModel.isAlertPresented,
			actions: {
				Button("Отмена", role: .cancel, action: {})
				Button("Повторить", action: viewModel.repeatAction)
			})
		.task(viewModel.load)
		.loading(viewModel.isLoading)
	}
}

private struct PaymentMethodsGrid: View {
	let methods: [PaymentMethod]
	let selectedMethod: PaymentMethod?
	let onSelect: (PaymentMethod) -> Void

	private let columns = [
		GridItem(.flexible(), spacing: DesignSystem.Spacing.small2),
		GridItem(.flexible(), spacing: DesignSystem.Spacing.small2)
	]

	var body: some View {
		LazyVGrid(columns: columns, spacing: DesignSystem.Spacing.small2) {
			ForEach(methods) { method in
				PaymentMethodCell(
					method: method,
					isSelected: selectedMethod == method
				)
				.onTapGesture { onSelect(method) }
			}
		}
		.padding(DesignSystem.Padding.medium)
	}
}

private struct PaymentFooterView: View {
	let isButtonDisabled: Bool
	let onPay: () -> Void
	let onUserAgreement: () -> Void

	var body: some View {
		VStack(alignment: .leading, spacing: DesignSystem.Spacing.medium2) {
			VStack(alignment: .leading, spacing: .zero) {
				Text("Совершая покупку, вы соглашаетесь с условиями")
				Button("Пользовательского соглашения", action: onUserAgreement)
					.padding(.vertical, DesignSystem.Padding.xsmall2)
			}
			.font(DesignSystem.Font.caption2)

			Button("Оплатить", action: onPay)
				.buttonStyle(PrimaryButtonStyle())
				.disabled(isButtonDisabled)
		}
		.padding(DesignSystem.Padding.medium)
		.background(
			DesignSystem.Color.backgroundSecondary
				.clipShape(
					.rect(
						topLeadingRadius: DesignSystem.Radius.medium,
						topTrailingRadius: DesignSystem.Radius.medium
					)
				)
				.ignoresSafeArea(edges: .bottom)
		)
	}
}

// MARK: - Preview
#Preview {
	let service = MockPaymentServiceImpl()
	let viewModel = PaymentViewModel(paymentService: service, onSuccess: {})
	let rootCoordinator: any RootCoordinator = RootCoordinatorImpl()
	let coordinator = CartCoordinatorImpl(rootCoordinator: rootCoordinator)
	NavigationStack {
		PaymentView(viewModel: viewModel, coordinator: coordinator)
	}
}
