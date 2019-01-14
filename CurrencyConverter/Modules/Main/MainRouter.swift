//
//  MainRouter.swift
//  CurrencyConverter
//
//  Created by Vadim Osmanov on 1/10/19.
//  Copyright © 2019 Vadim Osmanov. All rights reserved.
//

import Foundation
import UIKit


class MainRouter: MainRouterProtocol{
    
    weak var viewController: MainViewController!
    
    init(viewController: MainViewController) {
        self.viewController = viewController
    }
    
    func showAboutScene() {
        let newViewController = StoryboardsUtils.getAboutViewController()
        if newViewController != nil{
            viewController.navigationController?.pushViewController(newViewController!, animated: true)
        }
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}
