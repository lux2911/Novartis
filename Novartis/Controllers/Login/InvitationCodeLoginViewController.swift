//
//  InvitationCodeLoginViewController.swift
//  Novartis
//
//  Created by Tomislav Luketic on 7/20/19.
//  Copyright © 2019 lux. All rights reserved.
//

import UIKit
import SVProgressHUD

class InvitationCodeLoginViewController: UIViewController {

    @IBOutlet weak var invitationCodeTxtFld: UITextField!
    
    @IBOutlet weak var sendBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        invitationCodeTxtFld.becomeFirstResponder()
    }
    
    
    private func setupView() {
        invitationCodeTxtFld.addTarget(self, action: #selector(LoginViewController.textFieldDidChange(_:)),
                                 for: UIControl.Event.editingChanged)
        
        sendBtn.setTitleColor(UIColor.lightGray, for: .disabled)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        sendBtn.isEnabled = !textField.text!.isEmpty
    }
   
    @IBAction func onSendTapped(_ sender: Any) {
        
       do
       {
           defer { SVProgressHUD.dismiss() }
           SVProgressHUD.show()
           try LoginManager.shared.login(with: invitationCodeTxtFld.text!) { result in
                switch result {
                case .success:
                    LoginViewController.showMainView()
                case .failure(let error):
                    self.displayError(error: error)
                }
            }
        }
       catch MustImplementFuncError.loginWithInvitationCode {
           print("Class must implement 'login(with invitationCode: String, completion:@escaping LoginCompletionBlock)' function !")
        }
       catch {
           print("Unexpected error!")
        }
        
    }
    
}
