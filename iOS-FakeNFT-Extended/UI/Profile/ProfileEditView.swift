//
//  ProfileEditView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Герман on 11.10.2025.
//

import SwiftUI

// MARK: - Интерфейс для редактирования
struct ProfileEditData: Equatable {
	var name: String
	var description: String
	var website: String
	var avatarURL: URL?
	static func == (lhs: ProfileEditData, rhs: ProfileEditData) -> Bool {
		lhs.name == rhs.name &&
		lhs.description == rhs.description &&
		lhs.website == rhs.website &&
		lhs.avatarURL?.absoluteString == rhs.avatarURL?.absoluteString
	}
}

// MARK: - Клоужеры
typealias ProfileSaveAction = (ProfileEditData) async -> Void
typealias ProfileCancelAction = () -> Void
typealias ProfileDismissAction = () -> Void

struct ProfileEditView: View {
	// MARK: - Входящие проперти
	private let initialData: ProfileEditData
	private let onSave: ProfileSaveAction
	private let onCancel: ProfileCancelAction
	private let onDismiss: ProfileDismissAction
	private let isSaving: Bool
	private let errorMessage: String?
	
	// MARK: - Локальная обработка
	@State private var data: ProfileEditData
	@State private var showAvatarMenu = false
	@State private var showAvatarUrlAlert = false
	@State private var avatarUrlInput = ""
	@State private var showExitAlert = false
	@State private var showErrorAlert = false
	init(
		initialData: ProfileEditData,
		onSave: @escaping ProfileSaveAction,
		onCancel: @escaping ProfileCancelAction,
		onDismiss: @escaping ProfileDismissAction,
		isSaving: Bool = false,
		errorMessage: String? = nil
	) {
		self.initialData = initialData
		self._data = State(initialValue: initialData)
		self.onSave = onSave
		self.onCancel = onCancel
		self.onDismiss = onDismiss
		self.isSaving = isSaving
		self.errorMessage = errorMessage
	}
	private var hasChanges: Bool {
		data.name != initialData.name ||
		data.description != initialData.description ||
		data.website != initialData.website ||
		data.avatarURL?.absoluteString != initialData.avatarURL?.absoluteString
	}
    var body: some View {
        VStack(spacing: 24) {
			HStack {
				Button(action: { exitEditing() }) {
					Image(.chevronLeft)
						.foregroundColor(.ypBlack)
				}
				Spacer()
			}
            ProfileImage(
                imageUrl: data.avatarURL,
                canEdit: true
            ) {
				showAvatarMenu = true
            }
			.actionSheet(isPresented: $showAvatarMenu) {
                ActionSheet(
                    title: Text(NSLocalizedString("Фото профиля", comment: "")),
                    buttons: [
                        .default(Text(NSLocalizedString("Изменить фото", comment: ""))) {
							avatarUrlInput = data.avatarURL?.absoluteString ?? ""
							showAvatarUrlAlert = true
                        },
                        .destructive(Text(NSLocalizedString("Удалить фото", comment: ""))) {
							data.avatarURL = nil
                        },
                        .cancel(Text(NSLocalizedString("Отмена", comment: "")))
                    ]
                )
            }
            .alert(NSLocalizedString("Ссылка на фото", comment: ""), isPresented: $showAvatarUrlAlert) {
                TextField(
                    NSLocalizedString("Ссылка на фото", comment: ""),
                    text: $avatarUrlInput
                )
                .keyboardType(.URL)
                Button(NSLocalizedString("Отмена", comment: "")) {
					avatarUrlInput = ""
                }
                Button(NSLocalizedString("Сохранить", comment: "")) {
					data.avatarURL = URL(string: avatarUrlInput)
					avatarUrlInput = ""
                }
            }
            VStack(alignment: .leading, spacing: 8) {
                Text(NSLocalizedString("Имя", comment: ""))
                    .font(Font(UIFont.headline3))
                TextField(
                    NSLocalizedString("Имя", comment: ""),
                    text: $data.name
                )
                .applyTextInputStyle()
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Описание")
                    .font(Font(UIFont.headline3))
                TextEditor(text: $data.description)
                    .applyTextInputStyle()
                    .scrollContentBackground(.hidden)
                    .frame(minHeight: 55, maxHeight: 155)
                    .fixedSize(horizontal: false, vertical: true)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text(NSLocalizedString("Сайт", comment: ""))
                    .font(Font(UIFont.headline3))
                TextField(
                    NSLocalizedString("Сайт", comment: ""),
                    text: $data.website
                )
                .applyTextInputStyle()
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
		.disabled(isSaving)
		.allowsHitTesting(!isSaving)
        .overlay(alignment: .bottom) {
            SaveButtonView(
                isVisible: hasChanges && !isSaving,
                onSave: {
                    Task {
						await onSave(data)
                    }
                }
            )
        }
        .overlay {
            ZStack {
                Color.ypLightGrey.cornerRadius(8)
                    .frame(width: 82, height: 82)
                    .colorScheme(.light)
                ProgressView()
                    .scaleEffect(1.3)
                    .colorScheme(.light)
            }
			.opacity(isSaving ? 1 : 0)
			.allowsHitTesting(false)
        }
        .padding(.horizontal)
        .background(Color.ypWhite)
        .navigationBarBackButtonHidden(true)
        .gesture(
			isSaving ? nil : DragGesture(minimumDistance: 30, coordinateSpace: .global)
                .onEnded { value in
                    if value.translation.width > 50 {
                        exitEditing()
                    }
                }
        )
		.alert(NSLocalizedString("Уверены,\nчто хотите выйти?", comment: ""), isPresented: $showExitAlert) {
			Button(NSLocalizedString("Остаться", comment: "")) {}
			Button(NSLocalizedString("Выйти", comment: "")) {
				onCancel()
				onDismiss()
			}
		}
		.alert("Ошибка", isPresented: $showErrorAlert) {
			Button("OK") { }
		} message: {
			Text(errorMessage ?? "Неизвестная ошибка")
		}
		.onChange(of: errorMessage) { _, newValue in
			if newValue != nil {
				showErrorAlert = true
			}
		}
    }
	// MARK: - Локальная обработка
	private func exitEditing() {
		if hasChanges {
			showExitAlert = true
		} else {
			onCancel()
			onDismiss()
		}
	}
}

#Preview("Редактирование") {
	ProfileEditView(
		initialData: ProfileEditData(
			name: "Герман",
			description: "iOS-разработчик, люблю SwiftUI",
			website: "https://github.com",
			avatarURL: URL(string: "https://i.pravatar.cc/300")
		),
		onSave: { data in
			print("Сохранено: \(data.name)")
		},
		onCancel: {
			print("Отмена")
		},
		onDismiss: {
			print("Закрыто")
		},
		isSaving: false
	)
}
