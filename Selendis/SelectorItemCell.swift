//
//  SelectorItemCell.swift
//  Selendis
//
//  Created by foxness on 9/28/20.
//

import UIKit

class SelectorItemCell: UITableViewCell, DataItemCell {
    static let IDENTIFIER = "selectorItemCell"
    
    @IBOutlet weak var textView: UILabel!
    
    var item: DataItem? {
        didSet {
            guard let item = item as? SelectorItem else {
                return
            }
            
            textView.text = "i am selector"
        }
    }
}
