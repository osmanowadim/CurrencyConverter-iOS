//
//  StoryboardUtils.swift
//  CurrencyConverter
//
//  Created by Vadim Osmanov on 1/10/19.
//  Copyright © 2019 Vadim Osmanov. All rights reserved.
//

import UIKit


struct StoryboardsUtils{
    
    /**
     Return `AboutViewController` using About storyboard
     */
    static func getAboutViewController() -> AboutViewController?{
        let storyBoard: UIStoryboard = UIStoryboard(name: "About", bundle: nil)
        guard let newViewController = storyBoard.instantiateViewController(withIdentifier: "AboutViewController")
            as? AboutViewController else {
                return nil
        }
        return newViewController
    }
    
}
