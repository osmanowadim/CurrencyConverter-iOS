//
//  AboutConfigurator.swift
//  CurrencyConverter
//
//  Created by Vadim Osmanov on 1/14/19.
//  Copyright © 2019 Vadim Osmanov. All rights reserved.
//

import Foundation


class AboutConfigurator: AboutConfiguratorProtocol{
    
    /**
     Configure all class in About module
     - parameters:
     - viewController: `AboutViewController`
     */
    func configure(with viewController: AboutViewController){
        let presenter = AboutPresenter(view: viewController)
        let interactor = AboutInteractor(presenter: presenter)
        let router = AboutRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
    
}
