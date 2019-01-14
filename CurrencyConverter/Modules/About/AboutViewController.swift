//
//  AboutViewController.swift
//  CurrencyConverter
//
//  Created by Vadim Osmanov on 1/10/19.
//  Copyright © 2019 Vadim Osmanov. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, AboutViewProtocol {
    
    var presenter: AboutPresenterProtocol!
    var configurator: AboutConfiguratorProtocol = AboutConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        //Create configuration for current module
        configurator.configure(with: self)
        presenter.configureView()
    }
    
}
