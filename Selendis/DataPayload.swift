//
//  DataPayload.swift
//  Selendis
//
//  Created by foxness on 9/27/20.
//

import Foundation

struct DataPayload: Decodable {
    let dataPairs: [DataPair]
    let viewIds: [String]
    
    enum CodingKeys: String, CodingKey {
        case dataPairs = "data"
        case viewIds = "view"
    }
}

struct DataPair: Decodable {
    let name: String
    let data: DataItem
    
    enum CodingKeys: String, CodingKey {
        case name
        case data
    }
}

enum DataItem: Decodable {
    case text(TextItem)
    case picture(PictureItem)
    case selector(SelectorItem)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let x = try? container.decode(TextItem.self) {
            self = .text(x)
            return
        }
        
        if let x = try? container.decode(PictureItem.self) {
            self = .picture(x)
            return
        }
        
        if let x = try? container.decode(SelectorItem.self) {
            self = .selector(x)
            return
        }
        
        throw DecodingError.typeMismatch(DataItem.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unknown DataItem type"))
    }

//    func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        switch self {
//        case .string(let x):
//            try container.encode(x)
//        case .innerItem(let x):
//            try container.encode(x)
//        }
//    }
}

struct TextItem: Decodable {
    let text: String

    enum CodingKeys: String, CodingKey {
        case text
    }
}

struct PictureItem: Decodable {
    let text: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case text, url
    }
}

struct SelectorItem: Decodable {
    let selectedId: Int
    let variants: [SelectorVariant]

    enum CodingKeys: String, CodingKey {
        case selectedId, variants
    }
}

struct SelectorVariant: Decodable {
    let id: Int
    let text: String

    enum CodingKeys: String, CodingKey {
        case id, text
    }
}
