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
        dataService.getData { [weak self] items in // not sure if weak is needed but better safe than sorry
            guard let self = self else { return }
            
            if let items = items {
                self.items = items
                self.dataViewDelegate?.displayItems(self.items)
            } else {
                print("I couldn't get data for some reason")
            }
        }
    }
    
    func textItemTapped(textItem: TextItem) {
        let message = "Ты нажал(а) на \(textItem.text)"
        dataViewDelegate?.displayMessage(message)
    }
    
    func pictureItemTapped(pictureItem: PictureItem) {
        let message = "Ты нажал(а) на картинку \(pictureItem.text)"
        dataViewDelegate?.displayMessage(message)
    }
    
    func selectorItemChosen(itemTitle: String) {
        let message = "Ты выбрал(а) \(itemTitle)"
        dataViewDelegate?.displayMessage(message)
    }
    
    func downloadImage(url: URL, callback: @escaping BaseImageDownloader.ImageCallback) {
        downloader.downloadImage(url: url, callback: callback)
    }
}
