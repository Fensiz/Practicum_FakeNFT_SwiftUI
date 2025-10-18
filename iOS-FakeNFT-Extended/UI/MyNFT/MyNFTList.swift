//
//  MyNFTList.swift
//  iOS-FakeNFT-Extended
//
//  Created by Hajime4life on 18.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import SwiftUI

struct MyNFTList: View {
    @State private var showContextMenu: Bool = false
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(1..<4) { _ in
                    MyNFTCell()
                        .padding([.top, .bottom, .leading])
                        .padding(.trailing, 39)
                }
            }
            .padding(.top, 20)
        }
        .navigationTitle("Мои NFT")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                // TODO: Добавить сортировку
                Button(action: { showContextMenu = true }) {
                    Image(.sort)
                }
                .foregroundColor(.ypBlack)
                .actionSheet(isPresented: $showContextMenu) {
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
    }
}

#Preview {
    
        NavigationView {
            LightDarkPreviewWrapper {
            NavigationLink(destination: MyNFTList()) {
                Text("Test")
            }
        }
    }
}
