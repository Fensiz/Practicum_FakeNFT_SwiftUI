//
//  ProfileEditView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Герман on 11.10.2025.
//

import SwiftUI

@MainActor @Observable final class ProfileEditViewModel {
	var profile: ShortProfileModel
	var isAvatarMenuShown = false
	var isAvatarAlertShown = false
	var isExitAlertShown = false
	var alertAvatarUrl = ""
	var isLoading = false
	var errorMessage: String?

	var isErrorShown: Bool {
		get {
			errorMessage != nil
		}
		set {
			if !newValue {
				errorMessage = nil
			}
		}
	}
	var isDataChanged: Bool {
		initialProfileData != profile
	}

	private let initialProfileData: ShortProfileModel
	private let onSave: (ShortProfileModel) async throws -> Void
	private let onClose: () -> Void

	init(
		profile: ShortProfileModel,
		saveAction: @escaping (ShortProfileModel) async throws -> Void,
		closeAction: @escaping () -> Void
	) {
		self.profile = profile
		initialProfileData = profile
		onSave = saveAction
		onClose = closeAction
	}

	func showAvatarMenu() {
		isAvatarMenuShown = true
	}

	func removePhoto() {
		profile.avatar = nil
	}

	func changePhoto() {
		alertAvatarUrl = profile.avatarString
		isAvatarAlertShown = true
	}

	func saveAndExit() {
		isLoading = true
		Task {
			defer { isLoading = false }
			do {
				try await onSave(profile)
				onClose()
			} catch {
				errorMessage = error.localizedDescription
			}
		}
	}

	func cancelExit() {
		isExitAlertShown = false
	}

	func exit() {
		if !isDataChanged {
			confirmExit()
		} else {
			isExitAlertShown = true
		}
	}

	func confirmExit() {
		onClose()
	}
}

struct ProfileEditView: View {
	@State var viewModel: ProfileEditViewModel
	let coordinator: any ProfileCoordinator

	var body: some View {
		VStack(spacing: 24) {
			AvatarView(imageURL: viewModel.profile.avatar, showBadge: true)
				.onTapGesture(perform: viewModel.showAvatarMenu)
				.confirmationDialog(
					"Фото профиля",
					isPresented: $viewModel.isAvatarMenuShown,
					titleVisibility: .visible
				) {
					Button("Изменить фото") {
						coordinator.showUrlEditAlert(
							for: $viewModel.profile.avatarString,
							title: "Ссылка на фото"
						)
					}
					Button("Удалить фото", role: .destructive, action: viewModel.removePhoto)
					Button("Отмена", role: .cancel) {}
				}
			FormField(title: "Имя", value: $viewModel.profile.name)
			FormField(title: "Описание", value: $viewModel.profile.description, fieldType: .textEditor)
			FormField(title: "Сайт", value: $viewModel.profile.websiteString)
			Spacer()
			Button("Сохранить", action: viewModel.saveAndExit)
				.buttonStyle(PrimaryButtonStyle())
				.opacity(viewModel.isDataChanged ? 1 : 0)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
		.disabled(viewModel.isLoading)
		.padding(.horizontal)
		.background(DesignSystem.Color.background)
		.navigationBarBackButtonHidden(true)
		.toolbar {
			BackToolbar(action: viewModel.exit)
		}
		.alert("Уверены,\nчто хотите выйти?", isPresented: $viewModel.isExitAlertShown) {
			Button("Остаться", action: viewModel.cancelExit)
			Button("Выйти", action: viewModel.confirmExit)
		}
		.alert("Ошибка", isPresented: $viewModel.isErrorShown) {
			Button("OK") { }
		} message: {
			Text(viewModel.errorMessage ?? "?")
		}
	}
}

struct UrlEditAlert: View {
	@State private var url: String
	@Binding private var urlForUpdate: String
	private let title: String
	private let cancelAction: () -> Void

	init(url: Binding<String>, title: String, cancelAction: @escaping () -> Void) {
		self.url = url.wrappedValue
		self._urlForUpdate = url
		self.title = title
		self.cancelAction = cancelAction
	}

	var body: some View {
		ZStack {
			Color.ypUBackground
				.ignoresSafeArea()
				.background(.ultraThinMaterial)
			VStack(spacing: 16) {
				VStack(spacing: 7) {
					Text(title)
						.font(DesignSystem.Font.bodySemibold)
					TextField(title, text: $url)
						.frame(height: 46)
						.padding(.horizontal, 16)
						.background(DesignSystem.Color.background)
						.clipShape(RoundedRectangle(cornerRadius: 11))
						.padding(.horizontal, 16)
				}
				VStack(spacing: .zero) {
					Divider()
					HStack(spacing: .zero) {
						Button(role: .cancel) {
							cancelAction()
						} label: {
							Text("Отмена")
								.font(DesignSystem.Font.bodyRegular)
						}
						.frame(maxWidth: .infinity)
						Divider()
						Button {
							urlForUpdate = url
							cancelAction()
						} label: {
							Text("Сохранить")
								.font(DesignSystem.Font.bodyBold)
						}
						.frame(maxWidth: .infinity)
					}
					.frame(height: 44)
				}
			}
			.frame(width: 273, height: 151, alignment: .bottom)
			.background(
				Color.ypAlert
			)
			.clipShape(RoundedRectangle(cornerRadius: 14))
		}
	}
}
#Preview {
	@Previewable @State var url: String = "https://asas"
	UrlEditAlert(url: $url, title: "Ссылка на фото", cancelAction: {})
}

struct FormField: View {
	enum FieldType {
		case textField
		case textEditor
	}
	let title: LocalizedStringKey
	@Binding var value: String
	let fieldType: FieldType

	init(title: LocalizedStringKey, value: Binding<String>, fieldType: FieldType = .textField) {
		self.title = title
		self._value = value
		self.fieldType = fieldType
		UITextView.appearance().textContainerInset =
				UIEdgeInsets(top: 11, left: 0, bottom: 11, right: 0)
	}

	init(title: String, value: Binding<String?>, fieldType: FieldType = .textField) {
		let binding = Binding(
			get: { value.wrappedValue ?? "" },
			set: { newValue in
				value.wrappedValue = newValue.isEmpty ? nil : newValue
			}
		)
		self.init(title: LocalizedStringKey(title), value: binding, fieldType: fieldType)
	}

	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(title)
				.font(DesignSystem.Font.headline3)
			Group {
				switch fieldType {
					case .textField:
						TextField(title, text: $value)
							.frame(height: 44)
					case .textEditor:
						TextEditor(text: $value)
							.frame(height: 132)
							.scrollContentBackground(.hidden)
				}
			}
			.font(DesignSystem.Font.bodyRegular)
			.foregroundStyle(DesignSystem.Color.textPrimary)
			.padding(.horizontal, DesignSystem.Padding.medium - (fieldType == .textEditor ? 5 : 0))
			.background(
				DesignSystem.Color.backgroundSecondary
					.cornerRadius(DesignSystem.Radius.small)
			)
		}
	}
}

#Preview {
	@Previewable @State var name = ""
	@Previewable @State var desc = ""
	FormField(title: "Имя", value: $name)
	FormField(title: "Описание", value: $desc, fieldType: .textEditor)
}
