//
//  DataService.swift
//  Selendis
//
//  Created by foxness on 9/27/20.
//

import Foundation

class DataService {
    private static let DATA_ENDPOINT = "https://pryaniky.com/static/json/sample.json"
    
    func getData(callback: @escaping (DataPayload?) -> Void) {
        if let dataUrl = URL(string: DataService.DATA_ENDPOINT) {
            Requests.get(url: dataUrl, completionHandler: { (data, response, error) in
                if let error = error {
                    callback(nil)
                    return
                }
                
                if let response = response,
                   let httpresponse = response as? HTTPURLResponse,
                   Requests.isResponseOk(httpresponse) {
                    
                    if let jsonData = data {
                        let payload = try! JSONDecoder().decode(DataPayload.self, from: jsonData)
                        callback(payload)
                    } else {
                        callback(nil)
                    }
                    
                } else {
                    callback(nil)
                }
            })
        } else {
            fatalError("Bad data endpoint")
        }
    }
}
