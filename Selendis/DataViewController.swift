//
//  DataViewController.swift
//  Selendis
//
//  Created by foxness on 9/27/20.
//

import UIKit

class DataViewController: UIViewController, DataViewDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    private let presenter = DataPresenter(dataService: NetworkDataService())
    private let downloader = ImageDownloader()
    
    private var items = [DataItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        presenter.attachView(self)
        presenter.loadData()
    }
    
    func displayData(_ dataList: [DataItem]) {
        items = dataList
        
        // I'm 99% sure 'weak' is not needed but better safe than sorry
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { items.count }
    
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
                
                if let pictureItem = item as? PictureItem, let url = URL(string: pictureItem.url) {
                    downloader.downloadImage(url: url) { imageData in
                        if let imageData = imageData {
                            if let image = UIImage(data: imageData) {
                                cell.setPicture(image)
                            }
                        }
                    }
                }
                
                return cell
            }
            
        case .selector:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SelectorItemCell.IDENTIFIER, for: indexPath) as? SelectorItemCell {
                cell.item = item
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

