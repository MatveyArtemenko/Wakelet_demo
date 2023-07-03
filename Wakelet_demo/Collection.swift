//
//  Collection.swift
//  Wakelet_demo
//
//  Created by admin on 17/04/2023.
//

import Foundation

struct UICollection: Identifiable, Codable, Equatable {
    let id: String
    var title: String
    var description: String
    var image: String
    var items: [UIItem]
}

// MARK: - Collection

struct Collection: Codable {
    func toUICollection() -> UICollection {
        return UICollection(id: self.result.data.id, title: self.result.data.metadata.title, description: self.result.data.metadata.description, image: self.result.data.images.coverImage, items: [])
    }

    let result: Result

    // MARK: - Result

    struct Result: Codable {
        let data: DataClass
    }

    // MARK: - DataClass

    struct DataClass: Codable {
        let id, originalID, updated: String
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
            case updated, metadata, owner, contentType, moderated, archived, permissions, publishedTo, copyable, visibility, created, root, images, childCount
            case parentID = "parentId"
        }
    }

    // MARK: - Images

    struct Images: Codable {
        let coverImage, backgroundImage, avatarImage: String
    }

    // MARK: - Metadata

    struct Metadata: Codable {
        let coverImage, backgroundImage, title, description: String
    }
}
