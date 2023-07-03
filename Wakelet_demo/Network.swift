//
//  Network.swift
//  Wakelet_demo
//
//  Created by admin on 17/04/2023.
//

import Foundation

enum RestEnum {
    case getItems(collectionId: String, cursor: String?)
    case addItem(collectionId: String)
    case deleteItem(itemId: String)
    case getMyCollections(cursor: String?)
    case createCollection(parentId: String, title: String)
    case deleteCollection(collectionId: String)
    case updateCollection(title: String, description: String, id: String)
    case getCollection(collectionId: String)
    case getImageById(id: String)
    case uploadImage(data: Data)
}

extension RestEnum {
    var baseURL: String {
        switch self {
        case .createCollection,
             .deleteCollection,
             .getMyCollections,
             .updateCollection:
            return "https://graphql.wakelet.com/"
        case .uploadImage:
            return "https://images.wakelet.com/upload/new/"
        default:
            return "https://wakelet.com/api/trpc"
        }
    }

    var path: String {
        switch self {
        case .getCollection:
            return "/content.getContent?input="
        case .getItems:
            return "/content.getChildContent?input="
        case .getImageById:
            return "/images.getImageById?input="
        case .deleteItem:
            return "/curation.deleteContent"
        case .deleteCollection:
            return ""
        default:
            return ""
        }
    }

    var method: String {
        switch self {
        case .uploadImage:
            return "PUT"
        case .createCollection,
             .deleteCollection,
             .deleteItem,
             .getMyCollections,
             .updateCollection:
            return "POST"
        default:
            return "GET"
        }
    }

    var headers: [String: String]? {
        var headers: [String: String]?
        headers = [
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwcm9maWxlIjoiL3Byb2ZpbGVzL21wTmM5RzhFcnV1NnZlTnVaTG5zaSIsImFjY291bnQiOiIvYWNjb3VudHMvNDIyZTEzMTgtYzlhMS00NWM2LWExOGYtMmZlNWQ2NmNkZjMwIiwicm9sZXMiOlsiZGVmYXVsdCJdLCJpYXQiOjE2ODE4MjI3NDZ9.B5k1MqCewK5A03KmzGzsE_2qKOU2KCwLQ1W6RjwvqO4",
            "Content-type": "application/json"
        ]
        switch self {
        case .createCollection:
            headers?["apollographql-client-version"] = "2.92.0-29200"
            headers?["X-APOLLO-OPERATION-NAME"] = "CreateCollection"
            headers?["useragent"] = "TEST"
            headers?["apollographql-client-name"] = "wakelet-apollo-ios"
        case .getMyCollections:
            headers?["apollographql-client-version"] = "2.92.0-29200"
            headers?["X-APOLLO-OPERATION-NAME"] = "MyCollections"
            headers?["useragent"] = "TEST"
            headers?["apollographql-client-name"] = "wakelet-apollo-ios"
        case .deleteCollection:
            headers?["apollographql-client-version"] = "2.92.0-29200"
            headers?["X-APOLLO-OPERATION-NAME"] = "DeleteCollection"
            headers?["useragent"] = "TEST"
            headers?["apollographql-client-name"] = "wakelet-apollo-ios"
        case .updateCollection:
            headers?["apollographql-client-version"] = "2.92.0-29200"
            headers?["X-APOLLO-OPERATION-NAME"] = "EditCollection"
            headers?["useragent"] = "TEST"
            headers?["apollographql-client-name"] = "wakelet-apollo-ios"
        case .uploadImage:
            return ["Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwcm9maWxlIjoiL3Byb2ZpbGVzL21wTmM5RzhFcnV1NnZlTnVaTG5zaSIsImFjY291bnQiOiIvYWNjb3VudHMvNDIyZTEzMTgtYzlhMS00NWM2LWExOGYtMmZlNWQ2NmNkZjMwIiwicm9sZXMiOlsiZGVmYXVsdCJdLCJpYXQiOjE2ODE4MjI3NDZ9.B5k1MqCewK5A03KmzGzsE_2qKOU2KCwLQ1W6RjwvqO4",
                    "Content-Type": "image/jpeg"]
        default:
            break
        }
        return headers
    }

    var rawData: Data? {
        switch self {
        case .uploadImage(let data):
            return data
        case .deleteCollection(let id):
            let dataDict: [String: Any] = ["operationName": "DeleteCollection",
                                           "query": "mutation DeleteCollection($id: ID!) {\n  deleteCollection(input: {id: $id}) {\n    __typename\n    eventId\n  }\n}",
                                           "variables": ["id": id]]
            if let data = try? JSONSerialization.data(withJSONObject: dataDict) {
                return data
            } else {
                return nil
            }
        case .getMyCollections(let cursor):
            let dataDict: [String: Any?] = ["operationName": "MyCollections",
                                            "query": "query MyCollections($query: String, $pageSize: Int!, $sortOrder: SortOrder!, $pageForward: Boolean!, $cursor: String) {\n  me {\n    __typename\n    allCollections(input: {query: $query, pageSize: $pageSize, sortOrder: $sortOrder, pageForward: $pageForward, cursor: $cursor}) {\n      __typename\n      pageInfo {\n        __typename\n        hasNextPage\n      }\n      edges {\n        __typename\n        cursor\n        node {\n          __typename\n          ...ServerCollection\n        }\n      }\n    }\n  }\n}\nfragment ServerCollection on Collection {\n  __typename\n  ...MinimalServerCollection\n  id\n  viewCount\n  children {\n    __typename\n    pageInfo {\n      __typename\n      totalCount\n    }\n  }\n  contributors {\n    __typename\n    pageInfo {\n      __typename\n      hasNextPage\n    }\n    edges {\n      __typename\n      node {\n        __typename\n        ...ServerContributor\n      }\n    }\n  }\n}\nfragment MinimalServerCollection on Collection {\n  __typename\n  id\n  hostProfile {\n    __typename\n    ...ServerProfile\n  }\n  backgroundImage {\n    __typename\n    ...ServerImage\n  }\n  coverImage {\n    __typename\n    ...ServerImage\n  }\n  copyAllowed\n  coverImageMode\n  title\n  description\n  assignment {\n    __typename\n    progress\n  }\n  visibility\n  creator {\n    __typename\n    ...ServerProfile\n  }\n  permissions {\n    __typename\n    ...CollectionPermissions\n  }\n  layoutEnum\n  createdTime\n  updatedTime\n  reactionCount {\n    __typename\n    ...AppReactionCount\n  }\n  copiedFrom {\n    __typename\n    id\n    title\n  }\n  userReactionForNode {\n    __typename\n    ...AppReaction\n  }\n}\nfragment ServerProfile on Person {\n  __typename\n  id\n  name\n  handle\n  avatarImage {\n    __typename\n    ...ServerImage\n  }\n  bio\n  followerInfo {\n    __typename\n    userIsFollowing\n  }\n  backgroundImage {\n    __typename\n    ...ServerImage\n  }\n  verified\n  badges {\n    __typename\n    key\n  }\n}\nfragment ServerImage on EmbeddedImage {\n  __typename\n  id\n  imageType\n  isDefault\n  blurHash\n  getImageByWidth {\n    __typename\n    ...ServerImageEntry\n  }\n  extraMeta\n}\nfragment ServerImageEntry on ImageSrcSetEntry {\n  __typename\n  uri\n  width\n  height\n}\nfragment CollectionPermissions on CollectionPermissions {\n  __typename\n  canLeaveCollection\n  canInviteContributors\n  canEditCollectionDetails\n  canDeleteCollection\n  canAddChildren\n  canEditAllItems\n  canCopyCollection\n  allowAllVisibilityOptions\n}\nfragment AppReactionCount on ReactionCount {\n  __typename\n  reactionType\n  count\n}\nfragment AppReaction on Reaction {\n  __typename\n  id\n  reactionType\n  actor {\n    __typename\n    ...ServerProfile\n  }\n  dateAdded\n}\nfragment ServerContributor on CollectionContributor {\n  __typename\n  id\n  person {\n    __typename\n    ...ServerProfile\n  }\n  roleEnum\n}",
                                            "variables": ["cursor": cursor, "pageForward": false, "pageSize": 10, "query": nil, "sortOrder": "DEFAULT"] as [String: Any?]]
            if let data = try? JSONSerialization.data(withJSONObject: dataDict) {
                return data
            } else {
                return nil
            }
        case .createCollection(let parentId, let title):
            let dataDict: [String: Any] = ["operationName": "CreateCollection",
                                           "query": "mutation CreateCollection($parentId: ID!, $title: String) {\n  createCollection(input: {parent: $parentId, overrides: {title: $title}}) {\n    __typename\n    collection {\n      __typename\n      ...ServerCollection\n    }\n    actor {\n      __typename\n      ...ServerProfile\n    }\n  }\n}\nfragment ServerCollection on Collection {\n  __typename\n  ...MinimalServerCollection\n  id\n  viewCount\n  children {\n    __typename\n    pageInfo {\n      __typename\n      totalCount\n    }\n  }\n  contributors {\n    __typename\n    pageInfo {\n      __typename\n      hasNextPage\n    }\n    edges {\n      __typename\n      node {\n        __typename\n        ...ServerContributor\n      }\n    }\n  }\n}\nfragment MinimalServerCollection on Collection {\n  __typename\n  id\n  hostProfile {\n    __typename\n    ...ServerProfile\n  }\n  backgroundImage {\n    __typename\n    ...ServerImage\n  }\n  coverImage {\n    __typename\n    ...ServerImage\n  }\n  copyAllowed\n  coverImageMode\n  title\n  description\n  assignment {\n    __typename\n    progress\n  }\n  visibility\n  creator {\n    __typename\n    ...ServerProfile\n  }\n  permissions {\n    __typename\n    ...CollectionPermissions\n  }\n  layoutEnum\n  createdTime\n  updatedTime\n  reactionCount {\n    __typename\n    ...AppReactionCount\n  }\n  copiedFrom {\n    __typename\n    id\n    title\n  }\n  userReactionForNode {\n    __typename\n    ...AppReaction\n  }\n}\nfragment ServerProfile on Person {\n  __typename\n  id\n  name\n  handle\n  avatarImage {\n    __typename\n    ...ServerImage\n  }\n  bio\n  followerInfo {\n    __typename\n    userIsFollowing\n  }\n  backgroundImage {\n    __typename\n    ...ServerImage\n  }\n  verified\n  badges {\n    __typename\n    key\n  }\n}\nfragment ServerImage on EmbeddedImage {\n  __typename\n  id\n  imageType\n  isDefault\n  blurHash\n  getImageByWidth {\n    __typename\n    ...ServerImageEntry\n  }\n  extraMeta\n}\nfragment ServerImageEntry on ImageSrcSetEntry {\n  __typename\n  uri\n  width\n  height\n}\nfragment CollectionPermissions on CollectionPermissions {\n  __typename\n  canLeaveCollection\n  canInviteContributors\n  canEditCollectionDetails\n  canDeleteCollection\n  canAddChildren\n  canEditAllItems\n  canCopyCollection\n  allowAllVisibilityOptions\n}\nfragment AppReactionCount on ReactionCount {\n  __typename\n  reactionType\n  count\n}\nfragment AppReaction on Reaction {\n  __typename\n  id\n  reactionType\n  actor {\n    __typename\n    ...ServerProfile\n  }\n  dateAdded\n}\nfragment ServerContributor on CollectionContributor {\n  __typename\n  id\n  person {\n    __typename\n    ...ServerProfile\n  }\n  roleEnum\n}",
                                           "variables": ["parentId": parentId, "title": title]]
            if let data = try? JSONSerialization.data(withJSONObject: dataDict) {
                return data
            } else {
                return nil
            }
        case .deleteItem(let itemId):
            if let data = try? JSONSerialization.data(withJSONObject: ["id": itemId]) {
                return data
            }
            return nil
        case .updateCollection(let title, let description, let id):
            let body: [String: Any?] = ["operationName": "EditCollection",
                                        "query": "mutation EditCollection($id: ID!, $image: String, $backgroundImage: String, $title: String, $description: String, $coverImageMode: CoverImageMode, $layout: Layout, $visibility: CollectionVisibility, $copyAllowed: Boolean, $contributorsCanEditAllCards: Boolean) {\n  updateCollection(input: {id: $id, image: $image, backgroundImage: $backgroundImage, title: $title, description: $description, coverImageMode: $coverImageMode, layout: $layout, visibility: $visibility, copyAllowed: $copyAllowed, contributorsCanEditAllCards: $contributorsCanEditAllCards}) {\n    __typename\n    ...ServerCollection\n  }\n}\nfragment ServerCollection on Collection {\n  __typename\n  ...MinimalServerCollection\n  id\n  viewCount\n  children {\n    __typename\n    pageInfo {\n      __typename\n      totalCount\n    }\n  }\n  contributors {\n    __typename\n    pageInfo {\n      __typename\n      hasNextPage\n    }\n    edges {\n      __typename\n      node {\n        __typename\n        ...ServerContributor\n      }\n    }\n  }\n}\nfragment MinimalServerCollection on Collection {\n  __typename\n  id\n  hostProfile {\n    __typename\n    ...ServerProfile\n  }\n  backgroundImage {\n    __typename\n    ...ServerImage\n  }\n  coverImage {\n    __typename\n    ...ServerImage\n  }\n  copyAllowed\n  coverImageMode\n  title\n  description\n  assignment {\n    __typename\n    progress\n  }\n  visibility\n  creator {\n    __typename\n    ...ServerProfile\n  }\n  permissions {\n    __typename\n    ...CollectionPermissions\n  }\n  layoutEnum\n  createdTime\n  updatedTime\n  reactionCount {\n    __typename\n    ...AppReactionCount\n  }\n  copiedFrom {\n    __typename\n    id\n    title\n  }\n  userReactionForNode {\n    __typename\n    ...AppReaction\n  }\n}\nfragment ServerProfile on Person {\n  __typename\n  id\n  name\n  handle\n  avatarImage {\n    __typename\n    ...ServerImage\n  }\n  bio\n  followerInfo {\n    __typename\n    userIsFollowing\n  }\n  backgroundImage {\n    __typename\n    ...ServerImage\n  }\n  verified\n  badges {\n    __typename\n    key\n  }\n}\nfragment ServerImage on EmbeddedImage {\n  __typename\n  id\n  imageType\n  isDefault\n  blurHash\n  getImageByWidth {\n    __typename\n    ...ServerImageEntry\n  }\n  extraMeta\n}\nfragment ServerImageEntry on ImageSrcSetEntry {\n  __typename\n  uri\n  width\n  height\n}\nfragment CollectionPermissions on CollectionPermissions {\n  __typename\n  canLeaveCollection\n  canInviteContributors\n  canEditCollectionDetails\n  canDeleteCollection\n  canAddChildren\n  canEditAllItems\n  canCopyCollection\n  allowAllVisibilityOptions\n}\nfragment AppReactionCount on ReactionCount {\n  __typename\n  reactionType\n  count\n}\nfragment AppReaction on Reaction {\n  __typename\n  id\n  reactionType\n  actor {\n    __typename\n    ...ServerProfile\n  }\n  dateAdded\n}\nfragment ServerContributor on CollectionContributor {\n  __typename\n  id\n  person {\n    __typename\n    ...ServerProfile\n  }\n  roleEnum\n}",
                                        "variables": ["backgroundImage": nil, "contributorsCanEditAllCards": false, "copyAllowed": false, "coverImageMode": "FULL", "description": description, "id": id, "image": "image", "layout": "LIST", "title": title, "visibility": "PRIVATE"] as [String: Any?]]

            if let data = try? JSONSerialization.data(withJSONObject: body) {
                return data
            } else {
                return nil
            }
        default:
            return nil
        }
    }

    var queryString: String? {
        var query: String
        switch self {
        case .getCollection(let id):
            query = "{\"id\":\"\(id)\"}"
        case .getItems(let id, let cursor):
            var cursorString = ""
            if let cursor = cursor {
                cursorString = ",\"cursor\":\"\(cursor)\""
            }
            query = "{\"id\":\"\(id)\"\(cursorString)}"
        case .getImageById(let id):
            query = "{\"id\":\"\(id)\"}"
        case .deleteItem(itemId: let id):
            query = "{\"id\":\"\(id)\"}"
        default:
            return nil
        }
        return query.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
    }
}

class Network {
    static let shared = Network()

    let urlSession = URLSession(configuration: .default)

    func makeRequest<T: Codable>(request: RestEnum) async throws -> T {
        guard let url = URL(string: request.baseURL + request.path) else {
            throw MyError.generic
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method
        request.headers?.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        if request.method == "GET" {
            urlRequest.url = URL(string: url.absoluteString + (request.queryString ?? ""))
        } else if request.method == "POST",
                  let data = request.rawData
        {
            urlRequest.httpBody = data
        }

        do {
            let (data, response) = try await urlSession.data(for: urlRequest)
            print(response)
            printJSON(data: data)
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                let result = decoded
                return result
            } catch {
                print(error)
                throw MyError.generic
            }
        } catch {
            print(error.localizedDescription)
            print("request failed: \(request)")
            throw MyError.generic
        }
    }

    func printJSON(data: Data) {
        if let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed),
           let data = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]),
           let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        {
            print(string)
        }
    }

    func downloadImage(url: URL, callback: @escaping (Data) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                callback(data)
            }
        }.resume()
    }
}

enum MyError: LocalizedError {
    case generic
}
