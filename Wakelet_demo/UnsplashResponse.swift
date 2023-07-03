//
//  UnsplashResponse.swift
//  Wakelet_demo
//
//  Created by admin on 27/04/2023.
//

import Foundation
import SwiftUI

struct Results: Codable {
    let total: Int
    let results: [Result]
}

struct Result: Codable {
    let id: String
    let description: String?
    let urls: Urls
}

struct Urls: Codable {
    let full, regular, small: String
}

//// MARK: - UnsplashResponse
// struct Results: Codable {
//    let total, totalPages: Int
//    let results: [Result]
//
//    enum CodingKeys: String, CodingKey {
//        case total
//        case totalPages = "total_pages"
//        case results
//    }
//
//    // MARK: - Result
//    struct Result: Codable {
//        let id: String
//        let createdAt: Date
//        let width, height: Int
//        let color, blurHash: String
//        let likes: Int
//        let likedByUser: Bool
//        let description: String
//        let user: User
//        let currentUserCollections: [String]
//        let urls: Urls
//        let links: ResultLinks
//
//        enum CodingKeys: String, CodingKey {
//            case id
//            case createdAt = "created_at"
//            case width, height, color
//            case blurHash = "blur_hash"
//            case likes
//            case likedByUser = "liked_by_user"
//            case description, user
//            case currentUserCollections = "current_user_collections"
//            case urls, links
//        }
//    }
//
//    // MARK: - ResultLinks
//    struct ResultLinks: Codable {
//        let linksSelf: String
//        let html, download: String
//
//        enum CodingKeys: String, CodingKey {
//            case linksSelf = "self"
//            case html, download
//        }
//    }
//
//    // MARK: - Urls
//    struct Urls: Codable {
//        let raw, full, regular, small: String
//        let thumb: String
//    }
//
//    // MARK: - User
//    struct User: Codable {
//        let id, username, name, firstName: String
//        let lastName, instagramUsername, twitterUsername: String
//        let portfolioURL: String
//        let profileImage: ProfileImage
//        let links: UserLinks
//
//        enum CodingKeys: String, CodingKey {
//            case id, username, name
//            case firstName = "first_name"
//            case lastName = "last_name"
//            case instagramUsername = "instagram_username"
//            case twitterUsername = "twitter_username"
//            case portfolioURL = "portfolio_url"
//            case profileImage = "profile_image"
//            case links
//        }
//    }
//
//    // MARK: - UserLinks
//    struct UserLinks: Codable {
//        let linksSelf: String
//        let html: String
//        let photos, likes: String
//
//        enum CodingKeys: String, CodingKey {
//            case linksSelf = "self"
//            case html, photos, likes
//        }
//    }
//
//    // MARK: - ProfileImage
//    struct ProfileImage: Codable {
//        let small, medium, large: String
//    }
//
//
// }
//
//
