//
//  UserTableViewCell.swift
//  MultipleTargetsSample
//
//  Created by Farrukh Javeid on 29/09/2018.
//  Copyright © 2018 The Right Software. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var userNameLabel: UILabel!
    
    //MARK:- Cell Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK:- Cell Configuration Method
    func configureCell(user: Users) {
        userNameLabel.text = user.userName
    }
}
