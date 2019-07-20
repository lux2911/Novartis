//
//  NewUserViewController.swift
//  Novartis
//
//  Created by Tomislav Luketic on 7/20/19.
//  Copyright © 2019 lux. All rights reserved.
//

import UIKit

class NewUserViewController: UIViewController {

    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        fullNameTextField.becomeFirstResponder()
    }
    
    private func setupView() {
        saveButton.layer.cornerRadius = 8.0
    }
    

    @IBAction func onSaveTapped(_ sender: Any) {
    }
    

}
