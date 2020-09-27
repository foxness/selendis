//
//  DataService.swift
//  Selendis
//
//  Created by user179838 on 9/27/20.
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
                        //let data =
                        //let str = String(data: data, encoding: .utf8)
                        //let str = String(decoding: data, as: UTF8.self)
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
