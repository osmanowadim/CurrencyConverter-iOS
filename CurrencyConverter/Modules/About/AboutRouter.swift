//
//  AboutRouter.swift
//  CurrencyConverter
//
//  Created by Vadim Osmanov on 1/14/19.
//  Copyright © 2019 Vadim Osmanov. All rights reserved.
//

import Foundation
import UIKit

class AboutRouter: AboutRouterProtocol{
    
    weak var viewController: AboutViewController!
    
    init(viewController: AboutViewController) {
        self.viewController = viewController
    }
    
}
