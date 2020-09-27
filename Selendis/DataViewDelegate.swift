//
//  DataViewDelegate.swift
//  Selendis
//
//  Created by foxness on 9/28/20.
//

import Foundation

protocol DataViewDelegate: AnyObject {
    func displayData(_ data: DataPayload)
}
