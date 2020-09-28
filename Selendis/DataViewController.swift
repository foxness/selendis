//
//  DataViewController.swift
//  Selendis
//
//  Created by foxness on 9/27/20.
//

import UIKit

class DataViewController: UIViewController, DataViewDelegate, UITableViewDataSource, UITableViewDelegate, SelectorDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    private let presenter = DataPresenter(dataService: NetworkDataService(), downloader: ImageDownloader())
    
    private var items = [DataItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        presenter.attachView(self)
        presenter.viewDidLoad()
    }
    
    func itemSelected(itemTitle: String) {
        presenter.selectorItemChosen(itemTitle: itemTitle)
    }
    
    func displayItems(_ dataList: [DataItem]) {
        items = dataList
    }
    
    func displayMessage(_ message: String) {
        print(message)
        
        let alert = UIAlertController(title: "Вау!", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { items.count }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        switch item.type {
        case .text: presenter.textItemTapped(textItem: item as! TextItem)
        case .picture: presenter.pictureItemTapped(pictureItem: item as! PictureItem)
        default: break
        }
    }
    
    func downloadAndSetImage(for pictureCell: PictureItemCell, item: PictureItem) {
        guard !pictureCell.hasPicture else { return }
        guard let url = URL(string: item.url) else { return }
        
        presenter.downloadImage(url: url) { imageData in
            guard let imageData = imageData else { return }
            guard let image = UIImage(data: imageData) else { return }
            
            pictureCell.setPicture(image)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        switch item.type {
        case .text:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TextItemCell.IDENTIFIER, for: indexPath) as? TextItemCell {
                cell.item = item
                return cell
            }
            
        case .picture:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PictureItemCell.IDENTIFIER, for: indexPath) as? PictureItemCell {
                cell.item = item
                downloadAndSetImage(for: cell, item: item as! PictureItem)
                return cell
            }
            
        case .selector:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SelectorItemCell.IDENTIFIER, for: indexPath) as? SelectorItemCell {
                cell.item = item
                cell.selectorDelegate = self
                return cell
            }
        }
        
        fatalError("Unknown item type")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let pictureCell = cell as? PictureItemCell {
            pictureCell.willDisplayCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: Int
        
        switch items[indexPath.row].type {
        case .text: height = TextItemCell.HEIGHT
        case .picture: height = PictureItemCell.HEIGHT
        case .selector: height = SelectorItemCell.HEIGHT
        }
        
        return CGFloat(height)
    }
}

