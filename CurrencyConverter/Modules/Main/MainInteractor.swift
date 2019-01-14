//
//  MainInteractor.swift
//  CurrencyConverter
//
//  Created by Vadim Osmanov on 1/10/19.
//  Copyright © 2019 Vadim Osmanov. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import ObjectMapper
import AlamofireObjectMapper


enum CurrencyChangingMode {
    case inputCurrencyChanging
    case outputCurrencyChanging
}

class MainInteractor: MainInteractorProtocol{
    
    weak var presenter: MainPresenterProtocol!
    var repository: MainRepository!
    private var disposeBag = DisposeBag()
    let currencyService: CurrencyServiceProtocol = CurrencyService()
    var currencyChangingMode: CurrencyChangingMode?
    
    required init(presenter: MainPresenterProtocol, repository: MainRepository) {
        self.presenter = presenter
        self.repository = repository
    }
    
    var inputValue: Double {
        set {
            currencyService.inputValue = newValue
        }
        get {
            return currencyService.inputValue
        }
    }
    var outputValue: Double {
        get {
            return currencyService.outputValue
        }
    }
    var inputCurrencyShortName: String {
        get {
            return currencyService.inputCurrency.id
        }
    }
    var outputCurrencyShortName: String {
        get {
            return currencyService.outputCurrency.id
        }
    }
    
    var inputCurrencyIndex: Int {
        get {
            return currencyService.inputCurrency.index!
        }
    }
    
    var outputCurrencyIndex: Int {
        get {
            return currencyService.outputCurrency.index!
        }
    }
    
    var outputCurrencyRatio: Double {
        get {
            return currencyService.outputCurrency.ratio!
        }
    }
    
    func getCurrencyNames() -> [String] {
        return currencyService.currencyNames
    }
    
    func currencyChanged(selectedIndex: Int) {
        if currencyService.currencies.count > selectedIndex {
            
            let newCurrency = currencyService.currencies[selectedIndex]
            getRatio(newCurrency: newCurrency)
        }
    }
    
    func inputCurrencyChanging() {
        currencyChangingMode = .inputCurrencyChanging
    }
    
    func outputCurrencyChanging() {
        currencyChangingMode = .outputCurrencyChanging
    }
    
    func getAllCurrencies(){
        repository.fetchAllCurrencies()
            .subscribe(
                onNext: { currencies in
                    self.currencyService.saveAllCurrencies(currencies: currencies)
                    self.currencyService.sortAndUpdateCurrentCurrencies()
                    self.getRatio(newCurrency: nil)
            },
                onError: { error in
                    debugPrint("Error = \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    func getRatio(newCurrency: Currency?){
        presenter.showHUD()
        
        var requestInputCurrencyShortName = inputCurrencyShortName
        var requestOutputCurrencyShortName = outputCurrencyShortName
        
        if let mode = self.currencyChangingMode, let newCurrency = newCurrency {
            switch mode {
            case .inputCurrencyChanging:
                requestInputCurrencyShortName = newCurrency.id
            case .outputCurrencyChanging:
                requestOutputCurrencyShortName = newCurrency.id
            }
        }
        
        repository.getRatio(inputCurrencyShortName: requestInputCurrencyShortName, outputCurrencyShortName: requestOutputCurrencyShortName)
            .subscribe(
                onNext: { ratio in
                    if let mode = self.currencyChangingMode, let newCurrency = newCurrency {
                        switch mode {
                        case .inputCurrencyChanging:
                            self.currencyService.inputCurrency = newCurrency
                            self.presenter.inputCurrencyNameUpdated()
                        case .outputCurrencyChanging:
                            self.currencyService.outputCurrency = newCurrency
                            self.presenter.outputCurrencyNameUpdated()
                        }}
                    self.currencyService.saveOutputCurrencyRatio(ratio: ratio)
                    self.presenter.hideHUD()
                    self.presenter.updateOutputValue()
                    self.presenter.updateRateText()
            },
                onError: { error in
                    debugPrint("Error = \(error)")
                    self.presenter.showAlertView(with: error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
}