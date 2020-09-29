//
//  DataService.swift
//  Selendis
//
//  Created by foxness on 9/27/20.
//

import Foundation

protocol DataService {
    func getData(callback: @escaping ([DataItem]?) -> Void)
}

class NetworkDataService: DataService {
    private static let DATA_ENDPOINT = "https://pryaniky.com/static/json/sample.json"
    
    func getData(callback: @escaping ([DataItem]?) -> Void) {
        guard let dataUrl = URL(string: NetworkDataService.DATA_ENDPOINT) else {
            fatalError("Bad data endpoint")
        }
        
        Requests.get(url: dataUrl) { (data, response, error) in
            if let error = error {
                callback(nil)
                return
            }
            
            if let response = response,
               let httpresponse = response as? HTTPURLResponse,
               Requests.isResponseOk(httpresponse) {
                
                if let jsonData = data,
                   let payload = try? JSONDecoder().decode(RawDataPayload.self, from: jsonData) {
                    let items = NetworkDataService.rawDataToDataList(payload)
                    callback(items)
                } else {
                    callback(nil)
                }
                
            } else {
                callback(nil)
            }
        }
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
        let itemDict = NetworkDataService.rawDataToItemDict(raw)
        let items = raw.viewIds.map { itemDict[$0]! }
        return items
    }
}
