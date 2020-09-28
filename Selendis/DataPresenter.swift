//
//  DataPresenter.swift
//  Selendis
//
//  Created by foxness on 9/28/20.
//

import Foundation

class DataPresenter {
    private let dataService: DataService
    weak var dataViewDelegate: DataViewDelegate?
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    func loadData() {
        dataService.getData { [weak self] data in
            if let data = data {
                self?.dataViewDelegate?.displayData(data)
            }
        }
    }
}
