//
//  CountryInfoCellTableViewCell.swift
//  Novartis
//
//  Created by Tomislav Luketic on 7/21/19.
//  Copyright © 2019 lux. All rights reserved.
//

import UIKit

class CountryInfoCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fieldLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
  
    
    func configure(with item: CountryInfo, index:Int, properties: [CountryField]) {
        let field = properties[index]
        let prop = item[field.rawValue]
        
        fieldLbl.text = prop.0.titlecased()
        valueLbl.text = prop.1
        
    }
  
}
