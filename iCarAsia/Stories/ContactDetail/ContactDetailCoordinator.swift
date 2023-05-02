//
//  ContactDetailCoordinator.swift
//  iCarAsia
//
//  Created by Afroz Zaheer on 02/05/2023.
//

import Foundation
import UIKit

class ContactDetailCoordinator: Coordinator {
    
    var delegate: NavigatePrevious?
    
    var navigationController: UINavigationController?
    private var contact: Contact?
    init(nav: UINavigationController, contact: Contact?) {
        self.navigationController = nav
        self.contact = contact
    }
    
    func start() {
        let vc = ContactDetailViewController.instantiate()
        let mode: ContactDetailVCMode = (self.contact == nil) ? .new : .update(contact: self.contact!)
        
        let vm = ContactDetailViewModel(title: "Detail", controllerMode: mode)
        vm.coordinator = self
        
        vc.bindWithVM(vm: vm)
        vm.view = vc
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func eventOccured(event: Event) {
        switch event {
        case .updateContactListWith(let contact):
            self.delegate?.navigateBack(data: contact)
            self.navigationController?.popViewController(animated: true)
        default:
            break
        }
    }
}

