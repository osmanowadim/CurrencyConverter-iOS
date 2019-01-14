//
//  MessageUtils.swift
//  CurrencyConverter
//
//  Created by Vadim Osmanov on 1/10/19.
//  Copyright © 2019 Vadim Osmanov. All rights reserved.
//

import SwiftMessages


open class MessageUtils{
    
    class var shared: MessageUtils {
        struct Static {
            static let instance: MessageUtils = MessageUtils()
        }
        return Static.instance
    }
    
    open func showMessage(theme: Theme, title: String, body: String, iconText: String){
        let messageView: MessageView = MessageView.viewFromNib(layout: .cardView)
        messageView.configureTheme(theme)
        messageView.configureDropShadow()
        messageView.configureContent(title: title, body: body, iconText: iconText)
        messageView.button?.isHidden = true
        messageView.iconImageView?.isHidden = false
        messageView.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        (messageView.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        SwiftMessages.show(view: messageView)
    }
    
    open func showMessageErrorConnection(){
        let messageView: MessageView = MessageView.viewFromNib(layout: .cardView)
        messageView.configureTheme(.error)
        messageView.configureDropShadow()
        messageView.configureContent(title: "Ooops", body: "No internet connection", iconText: "😳")
        messageView.button?.isHidden = true
        messageView.iconImageView?.isHidden = false
        messageView.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        (messageView.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        SwiftMessages.show(view: messageView)
    }
    
    open func showMessageError(body: String){
        let messageView: MessageView = MessageView.viewFromNib(layout: .cardView)
        messageView.configureTheme(.error)
        messageView.configureDropShadow()
        messageView.configureContent(title: "Error!", body: body, iconText: "🤔")
        messageView.button?.isHidden = true
        messageView.iconImageView?.isHidden = false
        messageView.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        (messageView.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        SwiftMessages.show(view: messageView)
    }
    
}
