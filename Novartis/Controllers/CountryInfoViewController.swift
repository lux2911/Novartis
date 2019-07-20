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
    
    lazy var viewModel: CountryInfoViewModel = {
        return CountryInfoViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        getCountryInfo()
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
