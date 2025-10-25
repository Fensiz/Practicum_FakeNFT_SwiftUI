//
//  ProfileEditView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Герман on 11.10.2025.
//

import SwiftUI

// MARK: - Интерфейс для редактирования
struct ProfileEditData {
	var name: String
	var description: String
	var website: String
	var avatarURL: URL?
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
	
	// MARK: - Локальная обработка
	@State private var data: ProfileEditData
	@State private var showAvatarMenu = false
	@State private var showAvatarUrlAlert = false
	@State private var avatarUrlInput = ""
	@State private var showExitAlert = false
	init(
		initialData: ProfileEditData,
		onSave: @escaping ProfileSaveAction,
		onCancel: @escaping ProfileCancelAction,
		onDismiss: @escaping ProfileDismissAction,
		isSaving: Bool = false
	) {
		self.initialData = initialData
		self._data = State(initialValue: initialData)
		self.onSave = onSave
		self.onCancel = onCancel
		self.onDismiss = onDismiss
		self.isSaving = isSaving
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
        .overlay(alignment: .bottom) {
            SaveButtonView(
                isVisible: hasChanges,
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
        }
        .padding(.horizontal)
        .background(Color.ypWhite)
        .navigationBarBackButtonHidden(true)
        .gesture(
            DragGesture(minimumDistance: 30, coordinateSpace: .global)
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
				onDismiss()  // ← вместо coordinator.goBack()
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
