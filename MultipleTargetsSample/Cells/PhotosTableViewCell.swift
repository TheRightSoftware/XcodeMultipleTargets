//
//  PhotosTableViewCell.swift
//  MultipleTargetsSample
//
//  Created by Farrukh Javeid on 29/09/2018.
//  Copyright © 2018 The Right Software. All rights reserved.
//

import UIKit
import Kingfisher

class PhotosTableViewCell: UITableViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var customimageView: UIImageView!
    @IBOutlet weak var imageNameLabel: UILabel!
    
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
    func configureCell(photo: Photo) {
        imageNameLabel.text = photo.photoTitle
        
        if let url = URL(string: photo.photoUrl) {
            customimageView.kf.setImage(with: url)
        }
    }
}
