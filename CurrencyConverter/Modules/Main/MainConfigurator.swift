//
//  MainConfigurator.swift
//  CurrencyConverter
//
//  Created by Vadim Osmanov on 1/10/19.
//  Copyright © 2019 Vadim Osmanov. All rights reserved.
//

import Foundation
import UIKit


class MainConfigurator: MainConfiguratorProtocol{
    
    func configure(with viewController: MainViewController) {
        let presenter = MainPresenter(view: viewController)
        let repository = MainRepository()
        let interactor = MainInteractor(presenter: presenter, repository: repository)
        let router = MainRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.currencyPickerView = viewController.currencyPickerView
        presenter.router = router
        viewController.currencyPickerView.delegate = presenter
    }
    
}
