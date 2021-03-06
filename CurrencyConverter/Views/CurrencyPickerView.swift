//
//  CurrencyPickerView.swift
//  CurrencyConverter
//
//  Created by Vadim Osmanov on 1/10/19.
//  Copyright © 2019 Vadim Osmanov. All rights reserved.
//

import UIKit


protocol CurrencyPickerViewProtocol: class {
    var arrayCurrencyNames: [String] { set get }
    var title: String { set get }
    var selectedCurrencyIndex: Int? { set get }
    func reload()
}

protocol CurrencyPickerViewDelegate {
    func currencyPickerViewCancelButtonClicked()
    func currencyPickerViewApplyButtonClicked(selectedRow: Int)
}

class CurrencyPickerView: UIView, UIPickerViewDataSource, UIPickerViewDelegate, CurrencyPickerViewProtocol {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var delegate: CurrencyPickerViewDelegate?
    private let numberOfComponents = 1
    private let componentIndex = 0
    
    var arrayCurrencyNames = [String]()
    var title = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var selectedCurrencyIndex: Int? {
        didSet {
            pickerView.selectRow(selectedCurrencyIndex!, inComponent: componentIndex, animated: false)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        delegate?.currencyPickerViewCancelButtonClicked()
    }
    
    @IBAction func applyButtonClicked(_ sender: Any) {
        delegate?.currencyPickerViewApplyButtonClicked(selectedRow: pickerView.selectedRow(inComponent: componentIndex))
    }
    
    /**
     Reload all components of CurrencyPickerView
     */
    func reload() {
        pickerView.reloadAllComponents()
    }
    
    /**
     Return `Int` count of components in UIPickerView
     - parameters:
     - pickerView: `UIPickerView`
     */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return numberOfComponents
    }
    
    /**
     Return `Int` count of items in UIPickerView
     - parameters:
     - pickerView: `UIPickerView`
     - numberOfRowsInComponent: `Int`
     */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayCurrencyNames.count
    }
    
    /**
     Return `String` name of selected Currency
     - parameters:
     - pickerView: `UIPickerView`
     - titleForRow: `Int`
     - forComponent: `Int`
     */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayCurrencyNames[row]
    }
    
    /**
     Setup CurrencyPickerView
     */
    private func xibSetup() {
        Bundle.main.loadNibNamed("CurrencyPickerView", owner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
}
