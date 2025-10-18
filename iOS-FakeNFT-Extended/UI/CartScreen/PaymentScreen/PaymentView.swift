//
//  PaymentView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 10.10.2025.
//

import SwiftUI

struct PaymentView: View {
	@State var viewModel: PaymentViewModel
	private let coordinator: any CartCoordinator
	private let columns = [
		GridItem(.flexible(), spacing: 7), GridItem(.flexible(), spacing: 7)
	]

	init(coordinator: any CartCoordinator, viewModel: PaymentViewModel) {
		self.coordinator = coordinator
		self.viewModel = viewModel
	}

	var body: some View {
		ZStack {
			Color.ypWhite.ignoresSafeArea()
			if !viewModel.isLoading {
				VStack {
					LazyVGrid(columns: columns, spacing: 7) {
						ForEach(viewModel.paymentMethods) { method in
							PaymentMethodCell(
								method: method,
								isSelected: viewModel.selectedMethod == method
							)
							.onTapGesture {
								viewModel.select(method)
							}
						}
					}
					.padding(16)
					Spacer()
					VStack(alignment: .leading, spacing: 16) {
						VStack(alignment: .leading, spacing: 0) {
							Text("Совершая покупку, вы соглашаетесь с условиями")
							Button(
								"Пользовательского соглашения",
								action: coordinator.openUserAgreementScreen
							)
							.padding(.vertical, 4)
						}
						.font(.system(size: 13, weight: .regular))
						Button("Оплатить") {
							viewModel.pay {
								viewModel.onSuccess()
								coordinator.openSuccessPaymentScreen()
							}
						}
						.buttonStyle(PrimaryButtonStyle())
						.disabled(viewModel.isButtonDisabled)
					}
					.padding(16)
					.background(
						Color.ypLightGrey
							.clipShape(
								.rect(
									topLeadingRadius: 16,
									topTrailingRadius: 16
								)
							)
							.ignoresSafeArea(edges: .bottom)
					)
				}
			}
		}
		.navigationTitle("Выберите способ оплаты")
		.navigationBarTitleDisplayMode(.inline)
		.navigationBarBackButtonHidden(true)
		.toolbar {
			ToolbarItem(placement: .navigationBarLeading) {
				Button {
					coordinator.goBack()
				} label: {
					Image(.chevronLeft)
						.foregroundStyle(.ypBlack)
				}
			}
		}
		.onChange(of: viewModel.isLoading) { _, newValue in
			if newValue {
				UIBlockingProgressHUD.show()
			} else {
				UIBlockingProgressHUD.dismiss()
			}
		}
		.alert(
			"Не удалось произвести оплату",
			isPresented: $viewModel.isAlertPresented,
			actions: {
				Button("Отмена", role: .cancel, action: {})
				Button("Повторить") {
					viewModel.repeatAction()
				}
			})
		.task {
			viewModel.load()
		}
	}
}

// MARK: - Preview
#Preview {
	let service = MockPaymentServiceImpl()
	let viewModel = PaymentViewModel(paymentService: service, onSuccess: {})
	let rootCoordinator: any RootCoordinator = RootCoordinatorImpl()
	let coordinator = CartCoordinatorImpl(rootCoordinator: rootCoordinator)
	NavigationStack {
		PaymentView(coordinator: coordinator, viewModel: viewModel)
	}
}
