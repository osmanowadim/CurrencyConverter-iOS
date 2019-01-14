//
//  AboutProtocol.swift
//  CurrencyConverter
//
//  Created by Vadim Osmanov on 1/14/19.
//  Copyright © 2019 Vadim Osmanov. All rights reserved.
//

import Foundation


protocol AboutViewProtocol: class {
}

protocol AboutPresenterProtocol: class {
    var router: AboutRouterProtocol! { set get }
    func configureView()
}

protocol AboutInteractorProtocol: class {
}

protocol AboutRouterProtocol: class {
}

protocol AboutConfiguratorProtocol: class {
    func configure(with viewController: AboutViewController)
}
