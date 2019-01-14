//
//  AboutInteractor.swift
//  CurrencyConverter
//
//  Created by Vadim Osmanov on 1/14/19.
//  Copyright © 2019 Vadim Osmanov. All rights reserved.
//

import Foundation


class AboutInteractor: AboutInteractorProtocol{
    
    weak var presenter: AboutPresenterProtocol!
    
    required init(presenter: AboutPresenterProtocol) {
        self.presenter = presenter
    }
    
}
