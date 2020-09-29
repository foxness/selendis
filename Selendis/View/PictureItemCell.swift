//
//  PictureItemCell.swift
//  Selendis
//
//  Created by foxness on 9/28/20.
//

import UIKit

class PictureItemCell: UITableViewCell, DataItemCell {
    static let IDENTIFIER = "pictureItemCell"
    static let HEIGHT = 200
    
    @IBOutlet weak var pictureView: UIImageView?
    
    private var picture: UIImage?
    
    var item: DataItem? {
        didSet {
            guard let item = item as? PictureItem else { return }
            
            selectionStyle = .none
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
