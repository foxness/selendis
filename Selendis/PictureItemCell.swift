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
    @IBOutlet weak var pictureView: UIImageView?
    
    private var picture: UIImage?
    
    var hasPicture: Bool { picture != nil }
    
    var item: DataItem? {
        didSet {
            guard let item = item as? PictureItem else {
                return
            }
            
            textView.text = item.text
        }
    }
    
    private func showPicture() {
        DispatchQueue.main.async { [weak self] in
            if let picture = self?.picture {
                if let pictureView = self?.pictureView {
                    pictureView.image = picture
                } else {
                    fatalError("PictureView not found")
                }
            }
        }
    }
    
    func willDisplayCell() {
        showPicture()
    }
    
    func setPicture(_ picture: UIImage) {
        self.picture = picture
        showPicture()
    }
}
