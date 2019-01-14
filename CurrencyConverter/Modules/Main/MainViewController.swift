//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Vadim Osmanov on 1/10/19.
//  Copyright © 2019 Vadim Osmanov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, MainViewProtocol {
   
    @IBOutlet weak var HUDView: UIView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var loadCurrenciesButton: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var inputCurrencyButton: UIButton!
    @IBOutlet weak var swapButton: UIButton!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var outputCurrencyButton: UIButton!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var currencyPickerView: CurrencyPickerView!
    @IBOutlet weak var pickerViewAlignBottom: NSLayoutConstraint!
    
    var presenter: MainPresenterProtocol!
    var configurator: MainConfiguratorProtocol = MainConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func loadCurrencyButtonClicked(_ sender: Any) {
        presenter.loadCurrenciesButtonClicked()
    }
    
    @IBAction func inputCurrencyButtonClicked(_ sender: Any) {
         presenter.inputCurrencyButtonClicked()
    }
    
    @IBAction func outputCurrencyButtonClicked(_ sender: Any) {
        presenter.outputCurrencyButtonClicked()
    }
    
    @IBAction func infoButtonClicked(_ sender: Any) {
        presenter.infoButtonClicked()
    }
    
    @IBAction func swapButtonClicked(_ sender: Any) {
        presenter.swapButtonClicked()
    }
    
    func setInputValue(with value: String?) {
        DispatchQueue.main.async {
            self.inputTextField.text = value
        }
    }
    
    func setOutputValue(with value: String?) {
        DispatchQueue.main.async {
            self.outputLabel.text = value
        }
    }
    
    func setInputCurrencyShortName(with shortName: String) {
        DispatchQueue.main.async {
            self.inputCurrencyButton.setTitle(shortName, for: .normal)
        }
    }
    
    func setOutputCurrencyShortName(with shortName: String) {
        DispatchQueue.main.async {
            self.outputCurrencyButton.setTitle(shortName, for: .normal)
        }
    }
    
    func addDoneOnInputCurrencyKeyboard() {
        inputTextField.addDoneOnKeyboard()
    }
    
    func showHUD() {
        DispatchQueue.main.async {
            self.view.bringSubviewToFront(self.HUDView)
            self.activityIndicatorView.alpha = 1
            self.loadCurrenciesButton.alpha = 0
            UIView.animate(withDuration: 0.5) {
                self.HUDView.alpha = 1
            }
        }
    }
    
    func showLoadCurrenciesButton() {
        DispatchQueue.main.async {
            self.view.bringSubviewToFront(self.HUDView)
            self.activityIndicatorView.alpha = 0
            self.loadCurrenciesButton.alpha = 1
            UIView.animate(withDuration: 0.5) {
                self.HUDView.alpha = 1
            }
        }
    }
    
    func hideHUD() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5) {
                self.HUDView.alpha = 0
            }
        }
    }
    
    func showAlertView(with text: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "", message: text, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                
            })
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showPickerView() {
        UIView.animate(withDuration: 0.5) {
            self.pickerViewAlignBottom.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func hidePickerView() {
        UIView.animate(withDuration: 0.5) {
            self.pickerViewAlignBottom.constant = self.currencyPickerView.frame.size.height
            self.view.layoutIfNeeded()
        }
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    func setRateText(with rateText: String) {
        DispatchQueue.main.async {
            self.rateLabel.text = rateText
        }
    }
    
    private func setup(){
        //Create configuration for current module
        configurator.configure(with: self)
        presenter.configureView()
    }

}

extension MainViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        presenter.textFieldDidBeginEditing()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == inputTextField {
            if textField.availableAdding(string: string) {
                textField.addString(string)
                self.presenter.inputValueChanged(to: textField.text ?? "")
            }
            return false
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if textField == inputTextField {
            textField.clear()
            self.presenter.inputValueCleared()
            return false
        }
        return true
    }
    
}
