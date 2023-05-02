//
//  ProfilePicTableViewCell.swift
//  iCarAsia
//
//  Created by Afroz Zaheer on 01/05/2023.
//

import UIKit

class ProfilePicTableViewCell: UITableViewCell {
    @IBOutlet weak var picView: UIView! {
        didSet {
            picView.layer.cornerRadius = 50
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
        
}
