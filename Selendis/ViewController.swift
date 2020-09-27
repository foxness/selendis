//
//  ViewController.swift
//  Selendis
//
//  Created by foxness on 9/27/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let service = DataService()
        service.getData(callback: { data in
            print("got data")
            print(data)
        })
        print("testy")
    }
}

