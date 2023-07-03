//
//  CreateCollectionResponse.swift
//  Wakelet_demo
//
//  Created by admin on 24/04/2023.
//

import Foundation

// MARK: - CreateCollectionResponse

struct CreateCollectionResponse: Codable {
    let data: DataClass

    // MARK: - DataClass

    struct DataClass: Codable {
        let createCollection: CreateCollection
    }

    // MARK: - CreateCollection

    struct CreateCollection: Codable {
        let collection: Collection
        let actor: Actor
        let typename: String

        enum CodingKeys: String, CodingKey {
            case collection
            case actor
            case typename = "__typename"
        }
    }

    // MARK: - Actor

    struct Actor: Codable {
        let handle: String
        let badges: [String]?
        let id: String
        let avatarImage: Image
        let bio: String?
        let followerInfo: FollowerInfo
        let verified: Bool?
        let backgroundImage: Image
        let typename, name: String

        enum CodingKeys: String, CodingKey {
            case handle
            case badges
            case id
            case avatarImage
            case bio
            case followerInfo
            case verified
            case backgroundImage
            case typename = "__typename"
            case name
        }
    }

    // MARK: - Image

    struct Image: Codable {
        let id: String
        let imageType: String?
        let isDefault: Bool
        let extraMeta: String?
        let getImageByWidth: GetImageByWidth
        let typename: AvatarImageTypename
        let blurHash: String

        enum CodingKeys: String, CodingKey {
            case id
            case imageType
            case isDefault
            case extraMeta
            case getImageByWidth
            case typename = "__typename"
            case blurHash
        }
    }

    // MARK: - GetImageByWidth

    struct GetImageByWidth: Codable {
        let typename: GetImageByWidthTypename
        let width: Int
        let uri: String
        let height: Int

        enum CodingKeys: String, CodingKey {
            case typename = "__typename"
            case width, uri, height
        }
    }

    enum GetImageByWidthTypename: String, Codable {
        case imageSrcSetEntry = "ImageSrcSetEntry"
    }

    enum AvatarImageTypename: String, Codable {
        case embeddedImage = "EmbeddedImage"
    }

    // MARK: - FollowerInfo

    struct FollowerInfo: Codable {
        let userIsFollowing: Bool
        let typename: String

        enum CodingKeys: String, CodingKey {
            case userIsFollowing
            case typename = "__typename"
        }
    }

    // MARK: - Collection

    struct Collection: Codable {
        let layoutEnum, title, typename: String
        let hostProfile: Actor
        let assignment: String?
        let coverImageMode: String
        let creator: Actor
        let updatedTime: String
        let reactionCount: [ReactionCount]
        let viewCount: Int
        let visibility: String
        let children: Children
        let copyAllowed: Bool
        let createdTime, id: String
        let backgroundImage, coverImage: Image
        let copiedFrom: String?
        let permissions: Permissions
        let userReactionForNode: String?
        let contributors: Contributors
        let description: String

        enum CodingKeys: String, CodingKey {
            case layoutEnum
            case title
            case typename = "__typename"
            case hostProfile, assignment, coverImageMode, creator, updatedTime, reactionCount, viewCount, visibility, children, copyAllowed, createdTime, id, backgroundImage, coverImage, copiedFrom, permissions, userReactionForNode, contributors, description
        }
    }

    // MARK: - Children

    struct Children: Codable {
        let pageInfo: ChildrenPageInfo
        let typename: String

        enum CodingKeys: String, CodingKey {
            case pageInfo
            case typename = "__typename"
        }
    }

    // MARK: - ChildrenPageInfo

    struct ChildrenPageInfo: Codable {
        let totalCount: Int
        let typename: String

        enum CodingKeys: String, CodingKey {
            case totalCount
            case typename = "__typename"
        }
    }

    // MARK: - Contributors

    struct Contributors: Codable {
        let pageInfo: ContributorsPageInfo
        let edges: [Edge]
        let typename: String

        enum CodingKeys: String, CodingKey {
            case pageInfo
            case edges
            case typename = "__typename"
        }
    }

    // MARK: - Edge

    struct Edge: Codable {
        let node: Node
        let typename: String

        enum CodingKeys: String, CodingKey {
            case node
            case typename = "__typename"
        }
    }

    // MARK: - Node

    struct Node: Codable {
        let roleEnum, typename, id: String
        let person: Actor

        enum CodingKeys: String, CodingKey {
            case roleEnum
            case typename = "__typename"
            case id, person
        }
    }

    // MARK: - ContributorsPageInfo

    struct ContributorsPageInfo: Codable {
        let hasNextPage: Bool
        let typename: String

        enum CodingKeys: String, CodingKey {
            case hasNextPage
            case typename = "__typename"
        }
    }

    // MARK: - Permissions

    struct Permissions: Codable {
        let canCopyCollection, allowAllVisibilityOptions, canLeaveCollection, canInviteContributors: Bool
        let canDeleteCollection, canAddChildren, canEditAllItems: Bool
        let typename: String
        let canEditCollectionDetails: Bool

        enum CodingKeys: String, CodingKey {
            case canCopyCollection
            case allowAllVisibilityOptions
            case canLeaveCollection
            case canInviteContributors
            case canDeleteCollection
            case canAddChildren
            case canEditAllItems
            case typename = "__typename"
            case canEditCollectionDetails
        }
    }

    // MARK: - ReactionCount

    struct ReactionCount: Codable {
        let reactionType: String
        let count: Int
        let typename: String

        enum CodingKeys: String, CodingKey {
            case reactionType
            case count
            case typename = "__typename"
        }
    }
}
