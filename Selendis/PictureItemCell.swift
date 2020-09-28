//
//  PictureItemCell.swift
//  Selendis
//
//  Created by foxness on 9/28/20.
//

import UIKit

class PictureItemCell: UITableViewCell, DataItemCell {
    static let IDENTIFIER = "pictureItemCell"
    static let HEIGHT = 160
    
    @IBOutlet weak var textView: UILabel!
    @IBOutlet weak var pictureView: UIImageView!
    
    private var picture: UIImage?
    
    var item: DataItem? {
        didSet {
            guard let item = item as? PictureItem else {
                return
            }
            
            textView.text = item.text
        }
    }
    
    func willDisplayCell() {
        print("will display; \(pictureView == nil ? "picview nil" : " ") \(picture == nil ? "pic nil" : "")")
        
        if let picture = picture, let pictureView = pictureView {
            print("pic to imageview")
            pictureView.image = picture
        }
    }
    
    func setPicture(_ picture: UIImage) {
        print("set picture; \(pictureView == nil ? "picview nil" : "")")
        self.picture = picture
    }
}
