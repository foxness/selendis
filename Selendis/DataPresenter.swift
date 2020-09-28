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
        dataService.getData { [weak self] data in
            if let data = data {
                self?.dataViewDelegate?.displayData(data)
            } else {
                print("I couldn't get data for some reason")
            }
        }
    }
}
