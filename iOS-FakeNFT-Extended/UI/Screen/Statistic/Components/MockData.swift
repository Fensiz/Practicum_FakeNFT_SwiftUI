//
//  MockData.swift
//  iOS-FakeNFT-Extended
//
//  Created by Алина on 11.10.2025.
//
import Foundation

enum Avatar {
    static let user1 = "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/594.jpg"
    static let user2 = "https://cs13.pikabu.ru/post_img/big/2024/04/24/6/1713950388175292726.png"
    static let user3 = "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/844.jpg"
    static let user4 = "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/991.jpg"
    static let user5 = "https://clck.ru/3DUYFN"
    static let user6 = "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/255.jpg"
    static let user7 = "https://pixelbox.ru/wp-content/uploads/2021/04/ava-mult-vk-49.jpg"
}

struct MockData {
    static let users: [User] = [
        User(id: "1", name: "Alex", avatar: URL(string: Avatar.user1), nfts: Array(repeating: "NFT", count: 112),
             rating: "5"),
        User(id: "2", name: "Bill", avatar: URL(string: Avatar.user2), nfts: Array(repeating: "NFT", count: 98),
             rating: "4"),
        User(id: "3", name: "Alla", avatar: URL(string: Avatar.user3), nfts: Array(repeating: "NFT", count: 72),
             rating: "3"),
        User(id: "4", name: "Mads", avatar: nil, nfts: Array(repeating: "NFT", count: 71),
             rating: "3"),
        User(id: "5", name: "Timothée", avatar: URL(string: Avatar.user5), nfts: Array(repeating: "NFT", count: 51),
             rating: "2"),
        User(id: "6", name: "Lea", avatar: URL(string: Avatar.user6), nfts: Array(repeating: "NFT", count: 23),
             rating: "2"),
        User(id: "7", name: "Eric", avatar: URL(string: Avatar.user7), nfts: Array(repeating: "NFT", count: 11),
             rating: "1")
    ]
}
