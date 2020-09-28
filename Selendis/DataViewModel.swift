//
//  DataItemCell.swift
//  Selendis
//
//  Created by foxness on 9/28/20.
//

import Foundation
import UIKit

protocol DataViewModelItem {
    var type: DataViewModelItemType { get }
    var rowCount: Int { get }
    var sectionTitle: String { get }
}

extension DataViewModelItem {
    var rowCount: Int { 1 }
}

enum DataViewModelItemType {
    case text, picture, selector
}

class DataViewModelTextItem: DataViewModelItem {
    var type: DataViewModelItemType { .text }
    
    var sectionTitle: String { "Text Section" }
    
    var text: String
    
    init(textItem: TextItem) {
        text = textItem.text
    }
}

class DataViewModelPictureItem: DataViewModelItem {
    var type: DataViewModelItemType { .picture }
    
    var sectionTitle: String { "Picture Section" }
    
    var text: String
    var url: String
    
    init(pictureItem: PictureItem) {
        text = pictureItem.text
        url = pictureItem.url
    }
}

class DataViewModelSelectorItem: DataViewModelItem {
    var type: DataViewModelItemType { .selector }
    
    var sectionTitle: String { "Selector Section" }
    
    var selectedId: Int
    var variants: [SelectorVariant]
    
    init(selectorItem: SelectorItem) {
        selectedId = selectorItem.selectedId
        variants = selectorItem.variants
    }
}

class DataViewModel: NSObject {
    var items = [DataViewModelItem]()
    
    func setData(_ data: DataPayload) {
        let itemDict = data.dataPairs.reduce(into: [String: DataItem]()) { $0[$1.id] = $1.dataItem }
        
        for id in data.viewIds {
            let item: DataViewModelItem
            
            switch itemDict[id] {
            case .text(let textItem):
                item = DataViewModelTextItem(textItem: textItem)
            case .picture(let pictureItem):
                item = DataViewModelPictureItem(pictureItem: pictureItem)
            case .selector(let selectorItem):
                item = DataViewModelSelectorItem(selectorItem: selectorItem)
            default:
                fatalError("Unexpected data item type")
            }
            
            items.append(item)
        }
    }
}

extension DataViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        switch item.type {
        case .text:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TextItemCell.IDENTIFIER, for: indexPath) as? TextItemCell {
                cell.item = item
                return cell
            }
        case .picture:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PictureItemCell.IDENTIFIER, for: indexPath) as? PictureItemCell {
                cell.item = item
                return cell
            }
        case .selector:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SelectorItemCell.IDENTIFIER, for: indexPath) as? SelectorItemCell {
                cell.item = item
                return cell
            }
        }
        
        fatalError("Unknown item type")
    }
}
