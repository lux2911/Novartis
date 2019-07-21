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
    override func viewDidLoad() {
        super.viewDidLoad()

        invitationCodeTxtFld.becomeFirstResponder()
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
