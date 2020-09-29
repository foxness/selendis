//
//  RawDataPayload.swift
//  Selendis
//
//  Created by foxness on 9/27/20.
//

import Foundation

struct RawDataPayload: Decodable {
    let dataPairs: [RawDataPair]
    let viewIds: [String]
    
    enum CodingKeys: String, CodingKey {
        case dataPairs = "data"
        case viewIds = "view"
    }
}

struct RawDataPair: Decodable {
    let id: String
    let dataItem: RawDataItem
    
    enum CodingKeys: String, CodingKey {
        case id = "name"
        case dataItem = "data"
    }
    
}

enum RawDataItem: Decodable {
    case text(RawTextItem)
    case picture(RawPictureItem)
    case selector(RawSelectorItem)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let x = try? container.decode(RawSelectorItem.self) {
            self = .selector(x)
            return
        }
        
        if let x = try? container.decode(RawPictureItem.self) {
            self = .picture(x)
            return
        }
        
        if let x = try? container.decode(RawTextItem.self) {
            self = .text(x)
            return
        }
        
        throw DecodingError.typeMismatch(RawDataItem.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unknown DataItem type"))
    }
}

struct RawTextItem: Decodable {
    let text: String

    enum CodingKeys: String, CodingKey {
        case text
    }
}

struct RawPictureItem: Decodable {
    let text: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case text, url
    }
}

struct RawSelectorItem: Decodable {
    let selectedId: Int
    let options: [RawSelectorOption]

    enum CodingKeys: String, CodingKey {
        case selectedId
        case options = "variants"
    }
}

struct RawSelectorOption: Decodable {
    let id: Int
    let text: String

    enum CodingKeys: String, CodingKey {
        case id, text
    }
}
