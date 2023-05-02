//
//  HomeViewModel.swift
//  iCarAsia
//
//  Created by Afroz Zaheer on 01/05/2023.
//

import Foundation

class HomeViewModel<D: Requestable>: ViewModel {

    var coordinator: Coordinator?
    private let api: D
    
    var title: String? = nil
    var contactList: [Contact]?
    
    weak var view: HomeViewInputs?
    
    init(title: String?, apiCaller: D) {
        self.api = apiCaller
        self.title = title
    }
    
    func getContacts() {
        api.request(params: nil, api: nil) {[weak self] result in
            do {
                let list = try result.get() as? [Contact]
                self?.contactList = list
                self?.view?.didFetch()
            } catch {
                
            }
        }
    }
    
    func moveToDetail(contact: Contact?) {
        coordinator?.eventOccured(event: Event.moveToContactDetailView(contact: contact))
    }
    
    func updateItem(contact: Contact) {
        guard var list = contactList, !list.isEmpty else {return}
        if let index = list.firstIndex(of: contact) {
            // index found of this element
            list[index] = contact
            self.contactList = list
        } else if var list = contactList, !list.isEmpty {
            list.insert(contact, at: 0)
            self.contactList = list

        } else {
            contactList = [contact]
        }
        self.view?.didFetch()
    }
    
}
