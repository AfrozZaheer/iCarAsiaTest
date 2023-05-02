//
//  ContactsTableViewCell.swift
//  iCarAsia
//
//  Created by Afroz Zaheer on 01/05/2023.
//

import UIKit

class ContactCellViewModel: ViewModel {
    var coordinator: Coordinator?
    
    var name: String
    var img: String?
    init(name: String, img: String?) {
        self.name = name
        self.img = img
    }
}

class ContactsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var contactImageView: UIView! {
        didSet {
            contactImageView.backgroundColor = UIColor.appMainColor
            contactImageView.layer.cornerRadius = 25
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
    
    func updateWith(vm: ContactCellViewModel) {
        self.nameLbl.text = vm.name
//        self.contactImageView = vm.img //image will remain same
    }
    
}
