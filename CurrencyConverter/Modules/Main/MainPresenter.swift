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
    
    /**
     Get rateText for rate label. Return data in format like - 1 USD = 28.2759 UAH
     */
    var rateText: String {
        get {
            let inputShortName = interactor.inputCurrencyShortName
            let outputRatio = interactor.outputCurrencyRatio
            let outputShortName = interactor.outputCurrencyShortName
            
            return "1 \(inputShortName) = \(outputRatio) \(outputShortName)"
        }
    }
    
    /**
     Set inputValue
     - parameters:
     - newValue: value `String` or 0.0 (if value == nil)
     Get inputValue return `String`
     */
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
    
    /**
     Get outputValue return `String`
     */
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
    
    /**
     Configure MainViewController, update Rate text, download all currencies from network and show HUD
     */
    func configureView() {
        view?.setInputValue(with: inputValue)
        view?.setOutputValue(with: outputValue)
        view?.setInputCurrencyShortName(with: inputCurrencyShortName)
        view?.setOutputCurrencyShortName(with: outputCurrencyShortName)
        view?.addDoneOnInputCurrencyKeyboard()
        updateRateText()
        getAllCurrencies()
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
    
    /**
     Action by click on inputCurrencyButton
     -> Hide keyboard, show input CurrencyPickerView
     */
    func inputCurrencyButtonClicked() {
        view.hideKeyboard()
        interactor.inputCurrencyChanging()
        currencyPickerView?.title = inputCurrencyPickerViewTitle
        currencyPickerView?.arrayCurrencyNames = interactor.getCurrencyNames()
        currencyPickerView?.reload()
        currencyPickerView?.selectedCurrencyIndex = interactor.inputCurrencyIndex
        view.showPickerView()
    }
    
    /**
     Action by click on outputCurrencyButton
     -> Hide keyboard, show output CurrencyPickerView
     */
    func outputCurrencyButtonClicked() {
        view.hideKeyboard()
        interactor.outputCurrencyChanging()
        currencyPickerView?.title = outputCurrencyPickerViewTitle
        currencyPickerView?.arrayCurrencyNames = interactor.getCurrencyNames()
        currencyPickerView?.reload()
        currencyPickerView?.selectedCurrencyIndex = interactor.outputCurrencyIndex
        view.showPickerView()
    }
    
    /**
     Action by click on loadCurrencyButton
     -> Call getAllCurrencies() in MainInteractor
     */
    func loadCurrenciesButtonClicked() {
        getAllCurrencies()
    }
    
    /**
     Action by click on infoButton
     -> Call showAboutScene() in MainRouter
     */
    func infoButtonClicked() {
        router.showAboutScene()
    }
    
    /**
     Action by click on swapCurrencyButton
     -> Show HUD and call swapCurrencies() in MainInteractor
     */
    func swapButtonClicked() {
        if NetworkUtils.isConnectedToNetwork(){
            view.showHUD()
            interactor.swapCurrencies()
        } else{
            MessageUtils.shared.showMessageErrorConnection()
        }
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
    
    /**
     Show alert view
     - parameters:
     - text: `String` text of alert view
     */
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
    
    /**
     Action by click button `Apply` in CurrencyPickerView
     - parameters:
     - selectedRow: `Int` index of selected position in CurrencyPickerView
     */
    func currencyPickerViewApplyButtonClicked(selectedRow: Int) {
        view.hidePickerView()
        interactor.currencyChanged(selectedIndex: selectedRow)
    }
    
    /**
     Update output value
     - parameters:
     - inputText: `String` input Value
     */
    private func updateOutputValue(with inputText: String?) {
        inputValue = inputText
        view?.setOutputValue(with: outputValue)
    }
    
    /**
     Get all currencies from MainInteractor if there is Network connection.
     Else show message error connecction
     */
    private func getAllCurrencies(){
        if NetworkUtils.isConnectedToNetwork(){
            interactor.getAllCurrencies()
        }else{
            MessageUtils.shared.showMessageErrorConnection()
        }
    }
    
}
