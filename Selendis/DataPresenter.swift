//
//  DataPresenter.swift
//  Selendis
//
//  Created by foxness on 9/28/20.
//

import Foundation

class DataPresenter {
    private let dataService: DataService
    private weak var dataViewDelegate: DataViewDelegate?
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    func attachView(_ delegate: DataViewDelegate) {
        dataViewDelegate = delegate
    }
    
    func detachView() {
        dataViewDelegate = nil
    }
    
    func loadData() {
        dataService.getData { [weak self] rawData in
            if let rawData = rawData {
                let dataList = DataPresenter.rawDataToDataList(rawData)
                self?.dataViewDelegate?.displayData(dataList)
            } else {
                print("I couldn't get data for some reason")
            }
        }
    }
    
    private static func rawDataToDataList(_ raw: RawDataPayload) -> [DataItem] {
        var items = [DataItem]()
        
        let itemDict = raw.dataPairs.reduce(into: [String: RawDataItem]()) { $0[$1.id] = $1.dataItem }
        for id in raw.viewIds {
            let item: DataItem
            
            switch itemDict[id] {
            case .text(let textItem):
                item = TextItem(textItem: textItem)
            case .picture(let pictureItem):
                item = PictureItem(pictureItem: pictureItem)
            case .selector(let selectorItem):
                item = SelectorItem(selectorItem: selectorItem)
            default:
                fatalError("Unexpected data item type")
            }
            
            items.append(item)
        }
        
        return items
    }
}
