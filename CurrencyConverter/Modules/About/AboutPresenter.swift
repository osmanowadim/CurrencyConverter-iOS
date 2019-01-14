//
//  AboutPresenter.swift
//  CurrencyConverter
//
//  Created by Vadim Osmanov on 1/14/19.
//  Copyright © 2019 Vadim Osmanov. All rights reserved.
//

import Foundation


class AboutPresenter: AboutPresenterProtocol{
    
    weak var view: AboutViewProtocol!
    var interactor: AboutInteractorProtocol!
    var router: AboutRouterProtocol!
    
    /**
     Configure AboutViewController
     */
    func configureView() {
        //Configure view
    }
    
    required init(view: AboutViewProtocol) {
        self.view = view
    }
    
}
