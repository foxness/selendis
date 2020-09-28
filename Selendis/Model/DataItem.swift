//
//  DataItem.swift
//  Selendis
//
//  Created by foxness on 9/28/20.
//

import Foundation
import UIKit

protocol DataItem {
    var type: DataItemType { get }
}

enum DataItemType {
    case text, picture, selector
}

class TextItem: DataItem {
    var type: DataItemType { .text }
    
    var text: String
    
    init(textItem: RawTextItem) {
        text = textItem.text
    }
}

class PictureItem: DataItem {
    var type: DataItemType { .picture }
    
    var text: String
    var url: String
    
    init(pictureItem: RawPictureItem) {
        text = pictureItem.text
        url = pictureItem.url
    }
}

class SelectorItem: DataItem {
    var type: DataItemType { .selector }
    
    var selectedId: Int
    var variants: [String]
    
    init(selectorItem: RawSelectorItem) {
        selectedId = selectorItem.selectedId
        variants = selectorItem.variants.sorted { $0.id < $1.id }.map { $0.text }
    }
}
