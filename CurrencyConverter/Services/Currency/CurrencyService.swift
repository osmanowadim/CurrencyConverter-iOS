//
//  CurrencyService.swift
//  CurrencyConverter
//
//  Created by Vadim Osmanov on 1/11/19.
//  Copyright © 2019 Vadim Osmanov. All rights reserved.
//

import Foundation


struct CurrencyError : Error {
    let description : String
    var localizedDesc: String {
        return NSLocalizedString(description, comment: "")
    }
}

protocol CurrencyServiceProtocol: class {
    var currencies: [Currency] { set get }
    var currencyNames: [String] { set get }
    var inputValue: Double { set get }
    var outputValue: Double { get }
    var inputCurrency: Currency { set get }
    var outputCurrency: Currency { set get }
    func saveAllCurrencies(currencies: [Currency])
    func sortAndUpdateCurrentCurrencies()
    func saveOutputCurrencyRatio(ratio: Double)
}

class CurrencyService: CurrencyServiceProtocol {
    
    private let storageService: StorageServiceProtocol = StorageService()
    var currencies = [Currency]()
    var currencyNames = [String]()
    
    init() {
        inputValue = storageService.savedInputValue() ?? 1
        inputCurrency = storageService.savedInputCurrency() ?? DefaultCurrency.defaultCurrency1
        outputCurrency = storageService.savedOutputCurrency() ?? DefaultCurrency.defaultCurrency2
    }
    
    var inputValue: Double {
        didSet {
            if (oldValue != inputValue) {
                storageService.saveInputValue(with: inputValue)
            }
        }
    }
    var outputValue: Double {
        get {
            var value = inputValue
            value *= outputCurrency.ratio!
            return value
        }
    }
    var inputCurrency: Currency {
        didSet {
            if (oldValue != inputCurrency) {
                storageService.saveInputCurrency(with: inputCurrency)
            }
        }
    }
    var outputCurrency: Currency {
        didSet {
            if (oldValue != outputCurrency) {
                storageService.saveOutputCurrency(with: outputCurrency)
            }
        }
    }
    
    func saveAllCurrencies(currencies: [Currency]) {
        self.currencies = currencies
        currencyNames = [String]()
    }
    
    func sortAndUpdateCurrentCurrencies() {
        if currencies.count > 0 {
            currencies.sort {
                $0.id < $1.id
            }
            
            var index = 0
            var inputCurrencyUpdated = false
            var outputCurrencyUpdated = false
            
            
            for position in currencies.indices {
                let name = "\(currencies[position].id!) : \(currencies[position].currencyName!)"
                currencyNames.append(name)
                currencies[position].index = index
                
                if inputCurrency.id == currencies[position].id {
                    inputCurrency = currencies[position]
                    inputCurrencyUpdated = true
                }
                if outputCurrency.id == currencies[position].id {
                    outputCurrency = currencies[position]
                    outputCurrencyUpdated = true
                }
                index += 1
            }
            
            if !inputCurrencyUpdated {
                inputCurrency = currencies.first!
            }
            if !outputCurrencyUpdated {
                outputCurrency = currencies.first!
            }
        }
    }
    
    func saveOutputCurrencyRatio(ratio: Double) {
        outputCurrency.ratio = ratio
        storageService.saveOutputCurrency(with: outputCurrency)
    }
}
