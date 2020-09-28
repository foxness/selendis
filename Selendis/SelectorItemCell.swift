//
//  SelectorItemCell.swift
//  Selendis
//
//  Created by foxness on 9/28/20.
//

import UIKit

class SelectorItemCell: UITableViewCell, DataItemCell, UIPickerViewDelegate, UIPickerViewDataSource {
    static let IDENTIFIER = "selectorItemCell"
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var selectedId: Int?
    var variants: [String]?
    
    var item: DataItem? {
        didSet {
            guard let item = item as? SelectorItem else {
                return
            }
            
            selectedId = item.selectedId
            variants = item.variants
            
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.selectRow(selectedId!, inComponent: 0, animated: false)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return variants?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return variants?[row]
    }
}
