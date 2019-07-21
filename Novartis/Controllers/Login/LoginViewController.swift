//
//  LoginViewController.swift
//  Novartis
//
//  Created by Tomislav Luketic on 7/20/19.
//  Copyright © 2019 lux. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTxtFld: UITextField!
    @IBOutlet weak var passTxtFld: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var newUserBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userNameTxtFld.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? NewUserViewController else {
            return
        }
        
        vc.userName = userNameTxtFld.text!
        vc.pass = passTxtFld.text!
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
        SVProgressHUD.show()
        LoginViewController.doLogin(userNameOrEmail: userNameTxtFld.text!, pass: passTxtFld.text!)
    }
    
    class func doLogin(userNameOrEmail: String, pass: String) {
        
        LoginManager.shared.login(userNameOrEmail: userNameOrEmail, pass: pass){
            result in
           
            SVProgressHUD.dismiss()
            
            switch result {
            case .success:
                LoginViewController.showMainView()
            case .failure(let error):
                UIApplication.shared.keyWindow?.rootViewController?.displayError(error: error)
            }
            
        }
    }
    
     class func showMainView() {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateInitialViewController() as! CountryInfoViewController
        
        UIApplication.shared.keyWindow?.rootViewController = vc
     }
      
   
}


