//
//  DataViewDelegate.swift
//  Selendis
//
//  Created by foxness on 9/28/20.
//

import Foundation

protocol DataViewDelegate: AnyObject {
    func displayItems(_ items: [DataItem])
    
    func displayMessage(_ message: String)
}
