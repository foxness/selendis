//
//  ViewController.swift
//  Selendis
//
//  Created by foxness on 9/27/20.
//

import UIKit

class ViewController: UIViewController, DataViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    private let presenter = DataPresenter(dataService: DataService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.dataViewDelegate = self
        presenter.viewLoaded()
    }
    
    func displayData(_ data: DataPayload) {
        print("I'm displaying data")
        print(data)
    }
}

