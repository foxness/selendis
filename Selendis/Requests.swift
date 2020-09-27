//
//  Requests.swift
//  Selendis
//
//  Created by foxness on 9/27/20.
//

import Foundation

struct Requests {
    private static let USER_AGENT = "hello there :^) nice to see that you're reading this"
    
    private static let session = URLSession.shared
    
    private init() { }
    
    static func isResponseOk(_ response: HTTPURLResponse) -> Bool { 200..<300 ~= response.statusCode }
    
    static func formRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(USER_AGENT, forHTTPHeaderField: "User-Agent")
        
        return request
    }
    
    static func get(url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let request = formRequest(url: url)
        session.dataTask(with: request, completionHandler: completionHandler).resume()
    }
}
