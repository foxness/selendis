//
//  TextItemCell.swift
//  Selendis
//
//  Created by foxness on 9/28/20.
//

import UIKit

class TextItemCell: UITableViewCell, DataItemCell {
    static let IDENTIFIER = "textItemCell"
    static let HEIGHT = 50
    
    @IBOutlet weak var textView: UILabel!
    
    var item: DataItem? {
        didSet {
            guard let item = item as? TextItem else {
                return
            }

            textView.text = item.text
            selectionStyle = .none
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
