//
//  ContactDetailViewModel.swift
//  iCarAsia
//
//  Created by Afroz Zaheer on 02/05/2023.
//

import Foundation

enum ContactDetailVCMode {
    case new
    case update(contact: Contact)
}

class ContactDetailViewModel: ViewModel {
    var coordinator: Coordinator?
    
    var title: String? = nil
    var contact: Contact?
    
    weak var view: ContactDetailViewControllerInputs?
    
    init(title: String?, controllerMode: ContactDetailVCMode) {
        switch controllerMode {
        case .new:
            self.contact = nil
        case .update(let contact):
            self.contact = contact
        }
        self.title = title
    }
    
    func loadData() {
        view?.updateUIWith(contact: self.contact)
    }
    
    func addContactToList(contact: Contact) {
        coordinator?.eventOccured(event: .updateContactListWith(contact: contact))
    }
    
}
