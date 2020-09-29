//
//  SelectorItemCell.swift
//  Selendis
//
//  Created by foxness on 9/28/20.
//

import UIKit

class SelectorItemCell: UITableViewCell, DataItemCell, UIPickerViewDelegate, UIPickerViewDataSource {
    static let IDENTIFIER = "selectorItemCell"
    static let HEIGHT = 160
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var selectedId: Int?
    var options: [String]?
    
    weak var selectorDelegate: SelectorDelegate?
    
    var item: DataItem? {
        didSet {
            guard let item = item as? SelectorItem else { return }
            
            selectedId = item.selectedId
            options = item.options
            
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.selectRow(selectedId!, inComponent: 0, animated: false)
            
            selectionStyle = .none
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options?[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let options = options else { return }
        
        let title = options[row]
        selectorDelegate?.itemSelected(itemTitle: title)
    }
}
