//
//  TextField.swift
//  CurrencyConverter
//
//  Created by Vadim Osmanov on 1/10/19.
//  Copyright © 2019 Vadim Osmanov. All rights reserved.
//

import Foundation
import UIKit


extension UITextField {
    
    /**
     Return `Bool` for available adding `String` in TextField
     - parameters:
     - string: `String` new string in TextField
     */
    func availableAdding(string: String) -> Bool {
        switch string {
        case "":
            return self.text != ""
        case "0"..."9":
            return self.text != "0"
        case ".", ",":
            return self.text!.count > 0 && self.text!.range(of: ".") == nil && self.text!.range(of: ",") == nil
        default:
            return false
        }
    }
    
    /**
     Change TextField using incomming string
     - parameters:
     - string: `String`
     */
    func addString(_ string: String) {
        var newValue: String = self.text ?? ""
        var addingString = string
        if addingString == "", newValue.count > 0 {
            newValue.removeLast()
        } else if addingString != "" {
            if addingString == "," {
                addingString = "."
            }
            newValue.append(addingString)
        }
        self.text = newValue
    }
    
    /**
     Clear TextField
     */
    func clear() {
        self.text = ""
    }
    
    /**
     Add button `Done` to Keyboard
     */
    func addDoneOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.inputAccessoryView = keyboardToolbar
    }
    
    /**
     Dismiss Keyboard
     */
    @objc func dismissKeyboard() {
        self.resignFirstResponder()
    }
}
