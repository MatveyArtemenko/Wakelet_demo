import Foundation

// MARK: - GetMyCollectionsResponse

struct GetMyCollectionsResponse: Codable {
    func toUICollection(collection: AllCollectionsEdge) -> UICollection {
        return UICollection(id: collection.node.id, title: collection.node.title, description: collection.node.description, image: collection.node.coverImage.getImageByWidth.uri, items: [])
    }

    let data: DataClass

    // MARK: - DataClass

    struct DataClass: Codable {
        let me: Me
    }

    // MARK: - Me

    struct Me: Codable {
        let allCollections: AllCollections
        let typename: String

        enum CodingKeys: String, CodingKey {
            case allCollections
            case typename = "__typename"
        }
    }

    // MARK: - AllCollections

    struct AllCollections: Codable {
        let pageInfo: ContributorsPageInfo
        let edges: [AllCollectionsEdge]
        let typename: String

        enum CodingKeys: String, CodingKey {
            case pageInfo
            case edges
            case typename = "__typename"
        }
    }

    // MARK: - AllCollectionsEdge

    struct AllCollectionsEdge: Codable {
        let cursor: String
        let node: PurpleNode
        let typename: PurpleTypename

        enum CodingKeys: String, CodingKey {
            case cursor
            case node
            case typename = "__typename"
        }
    }

    // MARK: - PurpleNode

    struct PurpleNode: Codable {
        let layoutEnum: LayoutEnum
        let title: String
        let typename: FluffyTypename
        let hostProfile: Creator
        let assignment: String?
        let coverImageMode: CoverImageMode
        let creator: Creator
        let updatedTime: String
        let reactionCount: [ReactionCount]
        let viewCount: Int
        let visibility: Visibility
        let children: Children
        let copyAllowed: Bool
        let createdTime, id: String
        let backgroundImage, coverImage: Image
        let copiedFrom: String?
        let permissions: Permissions
        let userReactionForNode: [String]?
        let contributors: Contributors
        let description: String

        enum CodingKeys: String, CodingKey {
            case layoutEnum
            case title
            case typename = "__typename"
            case hostProfile, assignment, coverImageMode, creator, updatedTime, reactionCount, viewCount, visibility, children, copyAllowed, createdTime, id, backgroundImage, coverImage, copiedFrom, permissions, userReactionForNode, contributors, description
        }
    }

    // MARK: - Image

    struct Image: Codable {
        let id: String
        let imageType: String?
        let isDefault: Bool?
        let extraMeta: String?
        let getImageByWidth: GetImageByWidth
        let typename: BackgroundImageTypename
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

    enum BackgroundImageTypename: String, Codable {
        case embeddedImage = "EmbeddedImage"
    }

    // MARK: - Children

    struct Children: Codable {
        let pageInfo: ChildrenPageInfo
        let typename: ChildrenTypename

        enum CodingKeys: String, CodingKey {
            case pageInfo
            case typename = "__typename"
        }
    }

    // MARK: - ChildrenPageInfo

    struct ChildrenPageInfo: Codable {
        let totalCount: Int
        let typename: PageInfoTypename

        enum CodingKeys: String, CodingKey {
            case totalCount
            case typename = "__typename"
        }
    }

    enum PageInfoTypename: String, Codable {
        case pageInfo = "PageInfo"
    }

    enum ChildrenTypename: String, Codable {
        case contentConnection = "ContentConnection"
    }

    // MARK: - Contributors

    struct Contributors: Codable {
        let pageInfo: ContributorsPageInfo
        let edges: [ContributorsEdge]
        let typename: ContributorsTypename

        enum CodingKeys: String, CodingKey {
            case pageInfo
            case edges
            case typename = "__typename"
        }
    }

    // MARK: - ContributorsEdge

    struct ContributorsEdge: Codable {
        let node: FluffyNode
        let typename: TentacledTypename

        enum CodingKeys: String, CodingKey {
            case node
            case typename = "__typename"
        }
    }

    // MARK: - FluffyNode

    struct FluffyNode: Codable {
        let roleEnum: RoleEnum
        let typename: StickyTypename
        let id: ID
        let person: Creator

        enum CodingKeys: String, CodingKey {
            case roleEnum
            case typename = "__typename"
            case id, person
        }
    }

    enum ID: String, Codable {
        case mpNc9G8Eruu6VeNuZLnsi = "mpNc9G8Eruu6veNuZLnsi"
    }

    // MARK: - Creator

    struct Creator: Codable {
        let handle: Handle
        let badges: [String]?
        let id: ID
        let avatarImage: Image
        let bio: String?
        let followerInfo: FollowerInfo
        let verified: Bool?
        let backgroundImage: Image
        let typename: CreatorTypename
        let name: Name

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

    // MARK: - FollowerInfo

    struct FollowerInfo: Codable {
        let userIsFollowing: Bool
        let typename: FollowerInfoTypename

        enum CodingKeys: String, CodingKey {
            case userIsFollowing
            case typename = "__typename"
        }
    }

    enum FollowerInfoTypename: String, Codable {
        case followerInfo = "FollowerInfo"
    }

    enum Handle: String, Codable {
        case matveiArtemenko496 = "MatveiArtemenko496"
    }

    enum Name: String, Codable {
        case матвейАртеменко = "Матвей Артеменко"
    }

    enum CreatorTypename: String, Codable {
        case person = "Person"
    }

    enum RoleEnum: String, Codable {
        case collectionOwner = "COLLECTION_OWNER"
    }

    enum StickyTypename: String, Codable {
        case collectionContributor = "CollectionContributor"
    }

    enum TentacledTypename: String, Codable {
        case collectionContributorEdge = "CollectionContributorEdge"
    }

    // MARK: - ContributorsPageInfo

    struct ContributorsPageInfo: Codable {
        let hasNextPage: Bool
        let typename: PageInfoTypename

        enum CodingKeys: String, CodingKey {
            case hasNextPage
            case typename = "__typename"
        }
    }

    enum ContributorsTypename: String, Codable {
        case collectionContributorConnection = "CollectionContributorConnection"
    }

    enum CoverImageMode: String, Codable {
        case full
    }

    enum LayoutEnum: String, Codable {
        case list = "LIST"
    }

    // MARK: - Permissions

    struct Permissions: Codable {
        let canCopyCollection, allowAllVisibilityOptions, canLeaveCollection, canInviteContributors: Bool
        let canDeleteCollection, canAddChildren, canEditAllItems: Bool
        let typename: PermissionsTypename
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

    enum PermissionsTypename: String, Codable {
        case collectionPermissions = "CollectionPermissions"
    }

    // MARK: - ReactionCount

    struct ReactionCount: Codable {
        let reactionType: ReactionType
        let count: Int
        let typename: ReactionCountTypename

        enum CodingKeys: String, CodingKey {
            case reactionType
            case count
            case typename = "__typename"
        }
    }

    enum ReactionType: String, Codable {
        case clap
        case epic
        case like
        case love
        case wow
    }

    enum ReactionCountTypename: String, Codable {
        case reactionCount = "ReactionCount"
    }

    enum FluffyTypename: String, Codable {
        case collection = "Collection"
    }

    enum Visibility: String, Codable {
        case visibilityPrivate = "private"
    }

    enum PurpleTypename: String, Codable {
        case collectionEdge = "CollectionEdge"
    }
}
