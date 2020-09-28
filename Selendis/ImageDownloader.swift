//
//  ImageDownloader.swift
//  Selendis
//
//  Created by foxness on 9/28/20.
//

import Foundation

class ImageDownloader {
    typealias ImageCallback = (Data?) -> Void
    
    private class Download: Operation {
        private let url: URL
        private let callback: ImageCallback
        
        init(url: URL, callback: @escaping ImageCallback) {
            self.url = url
            self.callback = callback
        }
        
        override func main() {
            guard !isCancelled else { return }
            
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            
            Requests.get(url: url) { [unowned self] data, response, error in
                guard !self.isCancelled else { return }
                
                if let error = error {
                    callback(nil)
                } else if let data = data {
                    callback(data)
                } else {
                    callback(nil)
                }
                
                dispatchGroup.leave()
            }
            
            dispatchGroup.wait()
        }
    }
    
    private lazy var downloadQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "Download queue"
        queue.maxConcurrentOperationCount = 10
        return queue
    }()
    
    private func addToQueue(download: Download) {
        download.completionBlock = {
            guard !download.isCancelled else { return }
            
            print("download task complete")
        }
        
        downloadQueue.addOperation(download)
    }
    
    func downloadImage(url: URL, callback: @escaping ImageCallback) {
        let download = Download(url: url, callback: callback)
        addToQueue(download: download)
    }
    
    func cancelEverything() {
        downloadQueue.cancelAllOperations()
    }
}
