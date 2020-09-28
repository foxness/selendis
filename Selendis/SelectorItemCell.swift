//
//  SelectorItemCell.swift
//  Selendis
//
//  Created by foxness on 9/28/20.
//

import UIKit

class SelectorItemCell: UITableViewCell {
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
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
}
