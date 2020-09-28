//
//  PictureItemCell.swift
//  Selendis
//
//  Created by foxness on 9/28/20.
//

import UIKit

class PictureItemCell: UITableViewCell, DataItemCell {
    static let IDENTIFIER = "pictureItemCell"
    
    @IBOutlet weak var textView: UILabel!
    
    var item: DataItem? {
        didSet {
            guard let item = item as? PictureItem else {
                return
            }
            
            textView.text = item.text
        }
    }
}
