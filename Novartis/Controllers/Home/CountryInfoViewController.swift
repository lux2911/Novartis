//
//  CountryInfoViewController.swift
//  Novartis
//
//  Created by Tomislav Luketic on 7/20/19.
//  Copyright © 2019 lux. All rights reserved.
//

import UIKit

class CountryInfoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var imgView2: UIImageView!
    lazy var viewModel: CountryInfoViewModel = {
        return CountryInfoViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        initViewModel()
        getCountryInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupForOrientation(newCollection: traitCollection)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        setupForOrientation(newCollection: newCollection)
    }
    
    private func setupForOrientation(newCollection: UITraitCollection) {
        if newCollection.horizontalSizeClass == .regular {
            imgView2.isHidden = false
            containerStackView.axis = .horizontal
            
        } else {
            imgView2.isHidden = true
            containerStackView.axis = .vertical
            
        }
    }
    
    private func setupView() {
        tableView.tableFooterView = UIView()
    }
    
    private func initViewModel() {
        
        viewModel.reloadData = {
            self.tableView.reloadData()
        }
        viewModel.displayError = { error in
            self.displayError(error: error)
        }
    }
    
    private func getCountryInfo() {
        viewModel.getCountryInfo()
    }
    
}

extension CountryInfoViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.countryFields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryInfoCell") as! CountryInfoCellTableViewCell
       
        let data = viewModel.countryInfo!
        cell.configure(with: data, index: indexPath.row, properties: viewModel.countryFields)
        
        return cell
    }
    
    
}
