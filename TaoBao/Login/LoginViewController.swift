//
//  LoginViewController.swift
//  TaoBao
//
//  Created by liushungxi on 2018/10/11.
//  Copyright © 2018年 liushungxi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginAccountView: UIView!
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var verificationCodeTextField: UITextField!
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var accountOrPhoneButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNumberView.isHidden = true
        loginButton.layer.cornerRadius = 20
    }
    @IBAction func passwordLookOrUnlook(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        passwordTextField.isSecureTextEntry = !sender.isSelected
    }
    @IBAction func forgetPassword(_ sender: UIButton) {
    }
    @IBAction func loginAction(_ sender: UIButton) {
        var account = ""
        var password = ""
        if accountOrPhoneButton.isSelected{
            account = phoneNumberTextField.text!
            password = verificationCodeTextField.text!
        }else{
            account = accountTextField.text!
            password = passwordTextField.text!
        }
        print("账号:\(account) 密码:\(password)")
    }
    @IBAction func loginAccountOrPhone(_ sender: UIButton) {
        verificationCodeTextField.text = nil
        phoneNumberTextField.text = nil
        passwordTextField.text = nil
        accountTextField.text = nil
        sender.isSelected = !sender.isSelected
        phoneNumberView.center = loginAccountView.center
        phoneNumberView.isHidden = !sender.isSelected
        loginAccountView.isHidden = sender.isSelected
    }
    @IBAction func regiestAction(_ sender: UIButton) {
    }
    @IBAction func getVerificationCode(_ sender: UIButton) {
    }
    
}
