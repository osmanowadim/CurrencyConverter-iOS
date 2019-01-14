//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Vadim Osmanov on 1/11/19.
//  Copyright © 2019 Vadim Osmanov. All rights reserved.
//

import Foundation
import ObjectMapper


struct Currency: Mappable, Codable, Equatable {
    
    var currencyName: String!
    var currencySymbol: String!
    var id: String!
    var ratio: Double?
    var index: Int?
    
    init?(map: Map) {
    }
    
    init(currencyName: String, currencySymbol: String, id: String, ratio: Double, index: Int){
        self.currencyName = currencyName
        self.currencySymbol = currencySymbol
        self.id = id
        self.ratio = ratio
        self.index = index
    }
    
    /**
     Mapping data from object `Map`
     */
    mutating func mapping(map: Map) {
        currencyName <- map["currencyName"]
        currencySymbol <- map["currencySymbol"]
        id <- map["id"]
    }
    
    /**
     Return `Bool` by equals between 2 Currency
     - parameters:
     - lhs: `Currency` first Currency
     - rhs: `Currency` second Currency
     */
    static func == (lhs: Currency, rhs: Currency) -> Bool {
        if lhs.currencyName == rhs.currencyName, lhs.id == rhs.id, lhs.ratio == rhs.ratio, lhs.index == rhs.index {
            return true
        }
        return false
    }
    
}
