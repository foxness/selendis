//
//  DataViewController.swift
//  Selendis
//
//  Created by foxness on 9/27/20.
//

import UIKit

class DataViewController: UIViewController, DataViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var items = [DataItem]()
    
    private let presenter = DataPresenter(dataService: NetworkDataService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        presenter.dataViewDelegate = self
        presenter.loadData()
    }
    
    func displayData(_ data: RawDataPayload) {
        print("I'm displaying data")
        print(data)
        
        let itemDict = data.dataPairs.reduce(into: [String: RawDataItem]()) { $0[$1.id] = $1.dataItem }
        
        for id in data.viewIds {
            let item: DataItem
            
            switch itemDict[id] {
            case .text(let textItem):
                item = TextItem(textItem: textItem)
            case .picture(let pictureItem):
                item = PictureItem(pictureItem: pictureItem)
            case .selector(let selectorItem):
                item = SelectorItem(selectorItem: selectorItem)
            default:
                fatalError("Unexpected data item type")
            }
            
            items.append(item)
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
}

