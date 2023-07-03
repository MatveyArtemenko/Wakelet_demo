//
//  Item.swift
//  Wakelet_demo
//
//  Created by admin on 17/04/2023.
//

import Foundation
import SwiftUI

struct UIItem: Identifiable, Equatable, Codable {
    let id: String
    var title: String
    var image: String
    var url: String
    var uiImage: Data?
}

// MARK: - ItemsResponse

struct ItemsResponse: Codable {
    let result: Result

    // MARK: - Result

    struct Result: Codable {
        let data: DataClass
    }

    // MARK: - DataClass

    struct DataClass: Codable {
        let content: [Content]
        let cursor: String
    }

    // MARK: - Content

    struct Content: Codable {
        let id, originalID: String
        let privileges: [String: Bool]
        let updated: String
        let metadata: Metadata
        let owner, contentType: String
        let moderated, archived: Bool
        let permissions: [String: Bool]
        let publishedTo: [String]?
        let copyable: Bool
        let visibility, created, root: String
        let images: Images
        let childCount: Int
        let parentID: String

        enum CodingKeys: String, CodingKey {
            case id
            case originalID = "originalId"
            case privileges, updated, metadata, owner, contentType, moderated, archived, permissions, publishedTo, copyable, visibility, created, root, images, childCount
            case parentID = "parentId"
        }
    }

    // MARK: - Images

    struct Images: Codable {}

    // MARK: - Metadata

    struct Metadata: Codable {
        let domain: String
        let oEmbed: OEmbed?
        let title, image: String
        let favicon: String
        let description: String
        let remoteIDS: remoteIds?
        let url: String

        enum CodingKeys: String, CodingKey {
            case domain
            case oEmbed
            case title
            case image
            case favicon
            case description
            case remoteIDS = "remoteIds"
            case url
        }
    }

    struct remoteIds: Codable {
        let id: String?
        let type: String?
    }

    // MARK: - OEmbed

    struct OEmbed: Codable {
        let providerURL: String
        let version, providerName: String
        let width: Int
        let authorURL: String
        let thumbnailURL: String
        let title, type: String
        let thumbnailHeight, thumbnailWidth, height: Int
        let authorName, html: String

        enum CodingKeys: String, CodingKey {
            case providerURL = "provider_url"
            case version
            case providerName = "provider_name"
            case width
            case authorURL = "author_url"
            case thumbnailURL = "thumbnail_url"
            case title, type
            case thumbnailHeight = "thumbnail_height"
            case thumbnailWidth = "thumbnail_width"
            case height
            case authorName = "author_name"
            case html
        }
    }
}
