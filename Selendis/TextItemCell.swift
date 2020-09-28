//
//  TextItemCell.swift
//  Selendis
//
//  Created by foxness on 9/28/20.
//

import UIKit

class TextItemCell: UITableViewCell {
    static let IDENTIFIER = "textItemCell"
    
    @IBOutlet weak var textView: UILabel!
    
    var item: DataViewModelItem? {
        didSet {
            guard let item = item as? DataViewModelTextItem else {
                return
            }
            
            textView.text = item.text
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
