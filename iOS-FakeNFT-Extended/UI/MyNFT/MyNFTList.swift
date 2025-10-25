//
//  MyNFTList.swift
//  iOS-FakeNFT-Extended
//
//  Created by Hajime4life on 18.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import SwiftUI

struct MyNFTList: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: ProfileViewModel
    var body: some View {
        ScrollView {
            if let myNfts = viewModel.myNfts {
                VStack(spacing: 0) {
                    ForEach(myNfts) { nft in
                        MyNFTCell(nft: nft, author: viewModel.user?.name) {}
                            .padding([.vertical, .leading])
                            .padding(.trailing, 39)
                    }
                }
                .padding(.top, 20)
            }
        }
        .navigationTitle("Мои NFT")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                // TODO: Добавить сортировку
                Button(action: { viewModel.showSortContextMenu() } ) {
                    Image(.sort)
                }
                .foregroundColor(.ypBlack)
                .actionSheet(isPresented: $viewModel.wantToSortMyNft) {
                    ActionSheet(
                        title: Text("Сортировка"),
                        buttons: [
                            .default(Text("По цене")) {
                            },
                            .default(Text("По рейтингу")) {
                            },
                            .default(Text("По названию")) {
                            },
                            .cancel(Text("Закрыть"))
                        ]
                    )
                }
            }
            ToolbarItem(placement: .topBarLeading) {
                Button(action: { dismiss() } ) {
                    Image(.chevronLeft)
                }
                .foregroundColor(.ypBlack)
            }
        }
        .background(Color.ypWhite)
        .task {
            await viewModel.loadMyNFTs()
        }
        .alert("Ошибка", isPresented: .constant(viewModel.errorMessage != nil), actions: {
            Button("Отмена", role: .cancel) {
                viewModel.clearError()
            }
            Button("Повторить") {
                Task {
                    await viewModel.loadMyNFTs()
                }
            }
        }, message: {
            Text(viewModel.errorMessage ?? "Не удалось получить данные")
        })
    }
}
