//
//  ImageResponse.swift
//  Wakelet_demo
//
//  Created by admin on 18/04/2023.
//

import Foundation

// MARK: - GetImageResponse

struct GetImageResponse: Codable {
    let result: Result

    // MARK: - Result

    struct Result: Codable {
        let data: DataClass
    }

    // MARK: - DataClass

    struct DataClass: Codable {
        let resizerBaseURL: String
        let id, blurHash, originalID: String
        let imageSizes: ImageSizes
    }

    // MARK: - ImageSizes

    struct ImageSizes: Codable {
        let actual, background, cover, favicon: [Actual]
        let avatar: [Actual]

        enum CodingKeys: String, CodingKey {
            case actual = "ACTUAL"
            case background = "BACKGROUND"
            case cover = "COVER"
            case favicon = "FAVICON"
            case avatar = "AVATAR"
        }
    }

    // MARK: - Actual

    struct Actual: Codable {
        let url: String
        let width, height: Int
    }
}

// MARK: - GetDeleteResponse

struct GetDeleteResponse: Codable {
    let result: Result

    // MARK: - Result

    struct Result: Codable {}
}
