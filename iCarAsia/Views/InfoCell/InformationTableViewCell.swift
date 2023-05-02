//
//  InformationTableViewCell.swift
//  iCarAsia
//
//  Created by Afroz Zaheer on 01/05/2023.
//

import UIKit

enum InfomationFieldType: String {
    case firstName = "First Name"
    case lastName = "Last Name"
    case email = "Email"
    case phone = "Phone"
}

class InformationTableCellViewModel: ViewModel {
    var coordinator: Coordinator?
    
    var type: InfomationFieldType = .firstName
    var title: String {
        return type.rawValue
    }
    var text: String = ""
    
    init(type: InfomationFieldType, text: String) {
        self.type = type
        self.text = text
    }
}

protocol InformationTableViewCellDelegate: AnyObject {
    func infoCell(_ cell: InformationTableViewCell, updateTextField text: String, fieldType: InfomationFieldType)
}

class InformationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var infoField: UITextField!
    
    weak var delegate: InformationTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.infoField.delegate = self
    }
    
    func updateUIWith(vm: InformationTableCellViewModel) {
        infoField.text = vm.text
        title.text = vm.title
    }
}

extension InformationTableViewCell: UITextFieldDelegate {
   
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.infoCell(self, updateTextField: textField.text ?? "", fieldType: InfomationFieldType(rawValue: title.text!)!)
    }
}
