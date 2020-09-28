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
    private let downloader: BaseImageDownloader
    
    private var items = [DataItem]()
    
    init(dataService: DataService, downloader: BaseImageDownloader) {
        self.dataService = dataService
        self.downloader = downloader
    }
    
    func attachView(_ delegate: DataViewDelegate) {
        dataViewDelegate = delegate
    }
    
    func detachView() {
        dataViewDelegate = nil
    }
    
    func viewDidLoad() {
        dataService.getData { [weak self] rawData in // not sure if weak is needed but better safe than sorry
            guard let self = self else { return }
            
            if let rawData = rawData {
                self.items = DataPresenter.rawDataToDataList(rawData)
                self.dataViewDelegate?.displayItems(self.items)
            } else {
                print("I couldn't get data for some reason")
            }
        }
    }
    
    func textItemTapped(textItem: TextItem) {
        let message = "Вау! Ты нажал(а) на \(textItem.text)"
        dataViewDelegate?.displayMessage(message)
    }
    
    func pictureItemTapped(pictureItem: PictureItem) {
        let message = "Вау! Ты нажал(а) на картинку \(pictureItem.text)"
        dataViewDelegate?.displayMessage(message)
    }
    
    func selectorItemChosen(itemTitle: String) {
        let message = "Вау! Ты выбрал(а) \(itemTitle)"
        dataViewDelegate?.displayMessage(message)
    }
    
    func downloadImage(url: URL, callback: @escaping BaseImageDownloader.ImageCallback) {
        downloader.downloadImage(url: url, callback: callback)
    }
    
    private static func rawDataToItemDict(_ raw: RawDataPayload) -> [String: DataItem] {
        let rawDict = raw.dataPairs.reduce(into: [String: RawDataItem]()) { $0[$1.id] = $1.dataItem }
        var itemDict = [String: DataItem]()
        
        for key in rawDict.keys {
            let item: DataItem
            
            switch rawDict[key] {
            case .text(let textItem):
                item = TextItem(textItem: textItem)
            case .picture(let pictureItem):
                item = PictureItem(pictureItem: pictureItem)
            case .selector(let selectorItem):
                item = SelectorItem(selectorItem: selectorItem)
            default:
                fatalError("Unexpected data item type")
            }
            
            itemDict[key] = item
        }
        
        return itemDict
    }
    
    private static func rawDataToDataList(_ raw: RawDataPayload) -> [DataItem] {
        let itemDict = DataPresenter.rawDataToItemDict(raw)
        let items = raw.viewIds.map { itemDict[$0]! }
        return items
    }
}
