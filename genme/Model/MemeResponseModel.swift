//
//  MemeResponseModel.swift
//  genme
//
//  Created by Emirhan Karahan on 13.08.2023.
//

import Foundation

// MARK: - MemeResponseModel
struct MemeResponseModel: Codable {
    let success: Bool?
    let data: MemeData?
}

// MARK: - DataClass
struct MemeData: Codable {
    let memes: [Meme]?
}

// MARK: - Meme
struct Meme: Codable {
    let id, name: String?
    let url: String?
    let width, height, boxCount, captions: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, url, width, height
        case boxCount = "box_count"
        case captions
    }
}
