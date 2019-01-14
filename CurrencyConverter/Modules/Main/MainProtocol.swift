//
//  MainProtocol.swift
//  CurrencyConverter
//
//  Created by Vadim Osmanov on 1/10/19.
//  Copyright © 2019 Vadim Osmanov. All rights reserved.
//

import Foundation
import UIKit


protocol MainViewProtocol: class {
    func setInputValue(with value: String?)
    func setOutputValue(with value: String?)
    func setInputCurrencyShortName(with shortName: String)
    func setOutputCurrencyShortName(with shortName: String)
    func addDoneOnInputCurrencyKeyboard()
    func showHUD()
    func showLoadCurrenciesButton()
    func hideHUD()
    func showAlertView(with text: String)
    func showPickerView()
    func hidePickerView()
    func hideKeyboard()
    func setRateText(with rateText: String)
}

protocol MainPresenterProtocol: class {
    var router: MainRouterProtocol! { set get }
    var rateText: String { get }
    func configureView()
    func textFieldDidBeginEditing()
    func inputValueChanged(to newInputValue: String)
    func inputValueCleared()
    func inputCurrencyButtonClicked()
    func outputCurrencyButtonClicked()
    func loadCurrenciesButtonClicked()
    func infoButtonClicked()
    func swapButtonClicked()
    func showHUD()
    func showLoadCurrenciesButton()
    func hideHUD()
    func updateOutputValue()
    func showAlertView(with text: String)
    func inputCurrencyNameUpdated()
    func outputCurrencyNameUpdated()
    func updateRateText()
}

protocol MainInteractorProtocol: class {
    func getAllCurrencies()
    func getRatio(newCurrency: Currency?)
    var inputValue: Double { set get }
    var outputValue: Double { get }
    var inputCurrencyShortName: String { get }
    var outputCurrencyShortName: String { get }
    var inputCurrencyIndex: Int { get }
    var outputCurrencyIndex: Int { get }
    var outputCurrencyRatio: Double { get }
    func getCurrencyNames() -> [String]
    func inputCurrencyChanging()
    func outputCurrencyChanging()
    func currencyChanged(selectedIndex: Int)
}

protocol MainRouterProtocol: class {
    func showAboutScene()
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

protocol MainConfiguratorProtocol: class {
    func configure(with viewController: MainViewController)
}
