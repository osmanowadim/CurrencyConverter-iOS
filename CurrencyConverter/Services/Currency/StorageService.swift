//
//  StorageService.swift
//  CurrencyConverter
//
//  Created by Vadim Osmanov on 1/11/19.
//  Copyright © 2019 Vadim Osmanov. All rights reserved.
//

import Foundation


protocol StorageServiceProtocol: class {
    func savedInputValue() -> Double?
    func saveInputValue(with value: Double?)
    func savedInputCurrency() -> Currency?
    func saveInputCurrency(with currency: Currency)
    func savedOutputCurrency() -> Currency?
    func saveOutputCurrency(with currency: Currency)
}

class StorageService: StorageServiceProtocol {
    
    private let kSavedInputValue = "IBR.savedInputValue"
    private let kSavedInputCurrency = "IBR.savedInputCurrency"
    private let kSavedOutputCurrency = "IBR.savedOutputCurrency"
    
    /**
     Return `Double` saved input value or nil
     */
    func savedInputValue() -> Double? {
        if UserDefaults.standard.object(forKey: kSavedInputValue) != nil {
            return UserDefaults.standard.double(forKey: kSavedInputValue);
        }
        return nil
    }
    
    /**
     Save input value
     */
    func saveInputValue(with value: Double?) {
        if let newValue = value {
            UserDefaults.standard.set(newValue, forKey: kSavedInputValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    /**
     Return `Currency` saved input currency or nil
     */
    func savedInputCurrency() -> Currency? {
        if let data = UserDefaults.standard.value(forKey:kSavedInputCurrency) as? Data {
            let currency = try? PropertyListDecoder().decode(Currency.self, from: data)
            return currency
        }
        return nil
    }
    
    /**
     Save input currency
     */
    func saveInputCurrency(with currency: Currency) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(currency), forKey:kSavedInputCurrency)
        UserDefaults.standard.synchronize()
    }
    
    /**
     Return `Currency` saved output currency or nil
     */
    func savedOutputCurrency() -> Currency? {
        if let data = UserDefaults.standard.value(forKey:kSavedOutputCurrency) as? Data {
            let currency = try? PropertyListDecoder().decode(Currency.self, from: data)
            return currency
        }
        return nil
    }
    
    /**
     Save output currency
     */
    func saveOutputCurrency(with currency: Currency) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(currency), forKey:kSavedOutputCurrency)
        UserDefaults.standard.synchronize()
    }
    
}
