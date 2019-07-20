//
//  LoginViewController.swift
//  Novartis
//
//  Created by Tomislav Luketic on 7/20/19.
//  Copyright © 2019 lux. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTxtFld: UITextField!
    @IBOutlet weak var passTxtFld: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var newUserBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        userNameTxtFld.becomeFirstResponder()
    }
    
    private func setupView() {
        loginBtn.layer.cornerRadius = 8.0
        newUserBtn.layer.cornerRadius = 8.0
        
        loginBtn.setTitleColor(UIColor.lightGray, for: .disabled)
        newUserBtn.setTitleColor(UIColor.lightGray, for: .disabled)
        loginBtn.isEnabled = false
        newUserBtn.isEnabled = false
        
        userNameTxtFld.addTarget(self, action: #selector(LoginViewController.textFieldDidChange(_:)),
                                              for: UIControl.Event.editingChanged)
        passTxtFld.addTarget(self, action: #selector(LoginViewController.textFieldDidChange(_:)),
                                    for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        loginBtn.isEnabled = !(userNameTxtFld.text!.isEmpty || passTxtFld.text!.isEmpty)
        newUserBtn.isEnabled = loginBtn.isEnabled
    }
    
    @IBAction func onLoginTapped(_ sender: Any) {
        
        LoginManager.shared.login(userNameOrEmail: userNameTxtFld.text!, pass: passTxtFld.text!){
            result in
            
            switch result {
            case .success:
                self.showMainView()
            case .failure(let error):
               self.displayError(error: error)
            }
           
        }
        /*RestClient.shared.getCountryInfo { result in
            if result.isSuccess {
                
            }
            
            
        }*/
    }
    
    private func showMainView() {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateInitialViewController() as! CountryInfoViewController
        
        UIApplication.shared.keyWindow?.rootViewController = vc
        
    }
      
   
}


