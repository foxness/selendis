//
//  PictureItemCell.swift
//  Selendis
//
//  Created by foxness on 9/28/20.
//

import UIKit

class PictureItemCell: UITableViewCell {
    static let IDENTIFIER = "pictureItemCell"
    
    @IBOutlet weak var textView: UILabel!
    
    var item: DataViewModelItem? {
        didSet {
            guard let item = item as? DataViewModelPictureItem else {
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
