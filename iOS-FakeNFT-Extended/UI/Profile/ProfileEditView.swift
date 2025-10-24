//
//  ProfileEditView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Герман on 11.10.2025.
//

import SwiftUI

struct ProfileEditView: View {
    @EnvironmentObject var viewModel: ProfileViewModel
    @State var coordinator: any ProfileCoordinator
    @Environment(\.dismiss) private var dismiss

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
                imageUrl: viewModel.editingUser?.avatar,
                canEdit: true
            ) {
                viewModel.showContextMenu()
            }
            .actionSheet(isPresented: $viewModel.needToShowContextMenu) {
                ActionSheet(
                    title: Text(NSLocalizedString("Фото профиля", comment: "")),
                    buttons: [
                        .default(Text(NSLocalizedString("Изменить фото", comment: ""))) {
                            viewModel.showSiteEditAlert()
                        },
                        .destructive(Text(NSLocalizedString("Удалить фото", comment: ""))) {
                            viewModel.deleteAvatar()
                        },
                        .cancel(Text(NSLocalizedString("Отмена", comment: "")))
                    ]
                )
            }
            .alert(NSLocalizedString("Ссылка на фото", comment: ""), isPresented: $viewModel.needToshowSiteEditAlert) {
                TextField(
                    NSLocalizedString("Ссылка на фото", comment: ""),
                    text: viewModel.avatarBinding
                )
                .keyboardType(.URL)
                Button(NSLocalizedString("Отмена", comment: "")) {
                    viewModel.hideSiteEditAlert()
                    viewModel.setAvatarToDefault()
                }
                Button(NSLocalizedString("Сохранить", comment: "")) {
                    viewModel.applyAvatarUrl()
                    viewModel.hideSiteEditAlert()
                }
            }
            .alert(NSLocalizedString("Уверены,\nчто хотите выйти?", comment: ""), isPresented: $viewModel.wantExitHasChanges) {
                Button(NSLocalizedString("Остаться", comment: "")) {
                    viewModel.cancelExit()
                }
                Button(NSLocalizedString("Выйти", comment: "")) {
                    viewModel.setUserToDefault()
                    coordinator.goBack()
                }
            }
            VStack(alignment: .leading, spacing: 8) {
                Text(NSLocalizedString("Имя", comment: ""))
                    .font(Font(UIFont.headline3))
                TextField(
                    NSLocalizedString("Имя", comment: ""),
                    text: viewModel.nameBinding
                )
                .applyTextInputStyle()
            }
            VStack(alignment: .leading, spacing: 8) {
                Text(NSLocalizedString("Описание", comment: ""))
                    .font(Font(UIFont.headline3))
                TextEditor(text: viewModel.descriptionBinding)
                    .applyTextInputStyle()
                    .scrollContentBackground(.hidden)
                    .frame(minHeight: 40, maxHeight: 155)
                    .fixedSize(horizontal: false, vertical: true)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text(NSLocalizedString("Сайт", comment: ""))
                    .font(Font(UIFont.headline3))
                TextField(
                    NSLocalizedString("Сайт", comment: ""),
                    text: viewModel.websiteBinding
                )
                .applyTextInputStyle()
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .overlay(alignment: .bottom) {
            SaveButtonView(
                isVisible: viewModel.shouldShowSaveButton,
                onSave: {
                    Task {
                        await viewModel.saveProfile()
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
            .opacity(viewModel.isSaveInProgress ? 1 : 0)
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
        .onAppear {
            Task {
                await viewModel.loadProfile()
            }
        }
    }
    
    private func exitEditing() {
        if viewModel.checkExit() {
            viewModel.wantExitHasChanges = true
        } else {
            coordinator.goBack()
        }
    }
}
