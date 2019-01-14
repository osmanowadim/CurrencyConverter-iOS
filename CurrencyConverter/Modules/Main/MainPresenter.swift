//
//  MainPresenter.swift
//  CurrencyConverter
//
//  Created by Vadim Osmanov on 1/10/19.
//  Copyright © 2019 Vadim Osmanov. All rights reserved.
//

import Foundation


class MainPresenter: MainPresenterProtocol, CurrencyPickerViewDelegate{
    
    var router: MainRouterProtocol!
    weak var view: MainViewProtocol!
    var interactor: MainInteractorProtocol!
    weak var currencyPickerView: CurrencyPickerViewProtocol?
    let inputCurrencyPickerViewTitle = "Select input currency"
    let outputCurrencyPickerViewTitle = "Select output currency"
    
    var rateText: String {
        get {
            let inputShortName = interactor.inputCurrencyShortName
            let outputRatio = interactor.outputCurrencyRatio
            let outputShortName = interactor.outputCurrencyShortName
            
            return "1 \(inputShortName) = \(outputRatio) \(outputShortName)"
        }
    }
    
    var inputValue: String? {
        set {
            if let value = newValue {
                interactor.inputValue = Double(value) ?? 0.0
            }
        }
        get {
            var input = String(interactor.inputValue)
            if input.hasSuffix(".0") {
                input.removeLast(2)
            }
            return input
        }
    }
    var outputValue: String? {
        get {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 2
            formatter.roundingMode = .down
            formatter.usesGroupingSeparator = false
            let number = NSNumber(value: interactor.outputValue)
            var output = formatter.string(from: number)!
            
            if output.hasSuffix(".00") {
                output.removeLast(2)
            }
            return output
        }
    }
    var inputCurrencyShortName: String {
        get {
            return interactor.inputCurrencyShortName
        }
    }
    var outputCurrencyShortName: String {
        get {
            return interactor.outputCurrencyShortName
        }
    }
    
    required init(view: MainViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        view?.setInputValue(with: inputValue)
        view?.setOutputValue(with: outputValue)
        view?.setInputCurrencyShortName(with: inputCurrencyShortName)
        view?.setOutputCurrencyShortName(with: outputCurrencyShortName)
        view?.addDoneOnInputCurrencyKeyboard()
        updateRateText()
        interactor.getAllCurrencies()
        view?.showHUD()
    }
    
    func textFieldDidBeginEditing() {
        view.hidePickerView()
    }
    
    func inputValueChanged(to newInputValue: String) {
        updateOutputValue(with: newInputValue)
    }
    
    func inputValueCleared() {
        updateOutputValue(with: "")
    }
    
    func inputCurrencyButtonClicked() {
        view.hideKeyboard()
        interactor.inputCurrencyChanging()
        currencyPickerView?.title = inputCurrencyPickerViewTitle
        currencyPickerView?.arrayCurrencyNames = interactor.getCurrencyNames()
        currencyPickerView?.reload()
        currencyPickerView?.selectedCurrencyIndex = interactor.inputCurrencyIndex
        view.showPickerView()
    }
    
    func outputCurrencyButtonClicked() {
        view.hideKeyboard()
        interactor.outputCurrencyChanging()
        currencyPickerView?.title = outputCurrencyPickerViewTitle
        currencyPickerView?.arrayCurrencyNames = interactor.getCurrencyNames()
        currencyPickerView?.reload()
        currencyPickerView?.selectedCurrencyIndex = interactor.outputCurrencyIndex
        view.showPickerView()
    }
    
    func loadCurrenciesButtonClicked() {
        interactor.getAllCurrencies()
    }
    
    func infoButtonClicked() {
        router.showAboutScene()
    }
    
    func swapButtonClicked() {
        
    }
    
    func showHUD() {
        view.showHUD()
    }
    
    func showLoadCurrenciesButton() {
        view.showLoadCurrenciesButton()
    }
    
    func hideHUD() {
        view.hideHUD()
    }
    
    func updateOutputValue() {
        updateOutputValue(with: inputValue)
    }
    
    func showAlertView(with text: String) {
        view.showAlertView(with: text)
    }
    
    func inputCurrencyNameUpdated() {
        view?.setInputCurrencyShortName(with: inputCurrencyShortName)
    }
    
    func outputCurrencyNameUpdated() {
        view?.setOutputCurrencyShortName(with: outputCurrencyShortName)
    }
    
    func updateRateText() {
        view?.setRateText(with: rateText)
    }
    
    func currencyPickerViewCancelButtonClicked() {
        view.hidePickerView()
    }
    
    func currencyPickerViewApplyButtonClicked(selectedRow: Int) {
        view.hidePickerView()
        interactor.currencyChanged(selectedIndex: selectedRow)
    }
    
    private func updateOutputValue(with inputText: String?) {
        inputValue = inputText
        view?.setOutputValue(with: outputValue)
    }
    
}
