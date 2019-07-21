//
//  NewUserViewController.swift
//  Novartis
//
//  Created by Tomislav Luketic on 7/20/19.
//  Copyright © 2019 lux. All rights reserved.
//

import UIKit

class NewUserViewController: UIViewController {

    @IBOutlet weak var fullNameTxtFld: UITextField!
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var dobTxtFld: UITextField!
    @IBOutlet weak var countryTxtFld: UITextField!
   
    @IBOutlet var txtFields: [UITextField]!
    @IBOutlet weak var saveBtn: UIButton!
    
    var userName: String?
    var pass: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        fullNameTxtFld.becomeFirstResponder()
    }
    
    private func setupView() {
        saveBtn.layer.cornerRadius = 8.0
        
        txtFields.forEach { $0.addTarget(self, action: #selector(LoginViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)}
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        saveBtn.isEnabled = !txtFields.contains(where: { (txtField) -> Bool in
               txtField.text!.isEmpty
            })
    }
    

    @IBAction func onSaveTapped(_ sender: Any) {
        LoginManager.shared.newUser(newUserData: NewUserData(userNameOrEmail: userName!, pass: pass!, name: fullNameTxtFld.text!, email: emailTxtFld.text!, dob: dobTxtFld.text!, country: countryTxtFld.text!), completion: { result in
            
            switch result {
            case .success:
                LoginViewController.doLogin(userNameOrEmail: self.userName!, pass: self.pass!)
                
            case .failure(let error):
                self.displayError(error: error, title: "Error", handler: { action in
                    self.dismiss(animated: true, completion: nil)
                })
            }
           
        })
    }
    
    
    

    
}
