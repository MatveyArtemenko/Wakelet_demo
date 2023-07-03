//
//  DeleteCollectionResponse.swift
//  Wakelet_demo
//
//  Created by admin on 24/04/2023.
//

import Foundation

// MARK: - DeleteCollectionResponse

struct DeleteCollectionResponse: Codable {
    let data: DataClass

    // MARK: - DataClass

    struct DataClass: Codable {
        let deleteCollection: DeleteCollection
    }

    // MARK: - DeleteCollection

    struct DeleteCollection: Codable {
        let typename: String
        var eventID: String?
        enum CodingKeys: String, CodingKey {
            case eventID = "eventId"
            case typename = "__typename"
        }
    }
}
