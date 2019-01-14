//
//  Constants.swift
//  CurrencyConverter
//
//  Created by Vadim Osmanov on 1/10/19.
//  Copyright © 2019 Vadim Osmanov. All rights reserved.
//

import Foundation


struct API {
    
    static let baseUrl = "https://free.currencyconverterapi.com/api/v6/"
    
    static let allCurrencies = "currencies"
    static func ratioCurrencies(inputCurrencyShortName: String, outputCurrencyShortName: String) -> String {
        return "convert?q=\(inputCurrencyShortName)_\(outputCurrencyShortName)&compact=ultra"
    }
    
}

struct DefaultCurrency {
 
    static let defaultCurrency1 = Currency(currencyName: "United States Dollar", currencySymbol: "$", id: "USD", ratio: 28.27, index: 0)
    static let defaultCurrency2 = Currency(currencyName: "Ukrainian Hryvnia", currencySymbol: "₴", id: "UAH", ratio: 0.03, index: 0)
    
}
