//
//  ProfileEditView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Герман on 11.10.2025.
//

import SwiftUI

struct ProfileEditView: View {
    @State private var name = "Joaquin Phoenix"
    @State private var description = "Дизайнер из Казани, люблю цифровое искусство и бейглы."
    @State private var siteUrlString: String = "https://hello.com"
    @State private var showContextMenu: Bool = false
    @State private var showSiteEditAlert: Bool = false
    @State private var avatarUrlString: String = "https://tinyurl.com/mrxzhdb7"
    @State private var newAvatarUrlString: String = ""
    @State private var isSaveInProgress: Bool = false
    @State private var wantExitHasChanges: Bool = false
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(spacing: 24) {
            ProfileImage(imageUrl: URL(string: avatarUrlString) ?? nil, canEdit: true) {
                showContextMenu = true
            }
            .actionSheet(isPresented: $showContextMenu) {
                ActionSheet(
                    title: Text("Фото профиля"),
                    buttons: [
                        .default(Text("Изменить фото")) {
                            showSiteEditAlert = true
                        },
                        .destructive(Text("Удалить фото")) {
                            avatarUrlString = ""
                        },
                        .cancel(Text("Отмена"))
                    ]
                )
            }
            .alert("Ссылка на фото", isPresented: $showSiteEditAlert) {
                TextField(avatarUrlString, text: $newAvatarUrlString)
                    .keyboardType(.URL)
                Button("Отмена") {
                    showSiteEditAlert = false
                    newAvatarUrlString = ""
                }
                Button("Сохранить") {
                    avatarUrlString = newAvatarUrlString
                }
            }
            .alert("Уверены,\nчто хотите выйти?", isPresented: $wantExitHasChanges) {
                Button("Остаться") {
                    // TODO: Cancel action
                    print("Cancel")
                }
                Button("Выйти") {
                    // TODO: Exit action
                    print("Exit")
                }
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Имя")
                    .font(Font(UIFont.headline3))
                TextField("Joaquin Phoenix", text: $name)
                    .applyTextInputStyle()
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Описание")
                    .font(Font(UIFont.headline3))
                TextEditor(text: $description)
                    .applyTextInputStyle()
                    .scrollContentBackground(.hidden)
            }
            .frame(minHeight: 40, maxHeight: 155)
            .fixedSize(horizontal: false, vertical: true)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Сайт")
                    .font(Font(UIFont.headline3))
                TextField("", text: $siteUrlString)
                    .applyTextInputStyle()
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .overlay(alignment: .bottom, content: {
            // TODO: Show it when data was changed
            Button(action: {
                // TODO: Save action
                print("Saved")
            }) {
                Text("Сохранить")
                    .frame(maxWidth: .infinity)
                    .font(Font(UIFont.bodyBold))
                    .foregroundColor(.ypWhite)
                    .padding(.vertical, 19)
                    .padding(.horizontal, 8)
                    .background(Color.ypBlack.cornerRadius(16))
            }
            .padding()
        })
        .overlay {
            ZStack {
                Color.ypLightGrey.cornerRadius(8)
                    .frame(width: 82, height: 82)
                    .colorScheme(.light)
                ProgressView()
                    .scaleEffect(1.3)
                    .colorScheme(.light)
            }
            .opacity(isSaveInProgress ? 1 : 0)
        }
        .padding(.horizontal)
        .background(Color.ypWhite)
        .navigationBarBackButtonHidden(true) /// Может это лучше убрать, пока оставлю
        .introspectNavigationController { navigationController in /// Отключаем стандартный жест свайпа назад
            navigationController.interactivePopGestureRecognizer?.isEnabled = false
        }
        .gesture(
            DragGesture(minimumDistance: 30, coordinateSpace: .global)
            .onEnded { value in
                if value.translation.width > 50 {
                    // TODO: Тут нужна проверка, поменялись ли даннные, если нет то пропустим
                    wantExitHasChanges = true
                }
            }
        )
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

#Preview {
    NavigationView {
        ProfileEditView()
    }
}
