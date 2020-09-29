//
//  DataItem.swift
//  Selendis
//
//  Created by foxness on 9/28/20.
//

import Foundation

protocol DataItem {
    var type: DataItemType { get }
}

enum DataItemType {
    case text, picture, selector
}

struct TextItem: DataItem {
    let type: DataItemType = .text
    
    let text: String
    
    init(textItem: RawTextItem) {
        text = textItem.text
    }
}

struct PictureItem: DataItem {
    let type: DataItemType = .picture
    
    let text: String
    let url: String
    
    init(pictureItem: RawPictureItem) {
        text = pictureItem.text
        url = pictureItem.url
    }
}

struct SelectorItem: DataItem {
    let type: DataItemType = .selector
    
    let selectedId: Int
    let options: [String]
    
    init(selectorItem: RawSelectorItem) {
        selectedId = selectorItem.selectedId
        options = selectorItem.options.sorted { $0.id < $1.id }.map { $0.text }
    }
}
