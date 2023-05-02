//
//  HomeCoordinator.swift
//  iCarAsia
//
//  Created by Afroz Zaheer on 01/05/2023.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    weak var delegate: NavigatePrevious?
    
    var navigationController: UINavigationController?
    var homevM: HomeViewModel<HomeApiLoader>?
    init(nav: UINavigationController) {
        self.navigationController = nav
    }
    
    func start() {
        let api = HomeApiLoader()
        let homeVM = HomeViewModel(title: "Contacts", apiCaller: api)
        self.homevM = homeVM

        homeVM.coordinator = self
        let homeVC = HomeViewController.instantiate()
        homeVM.view = homeVC // bind view with VM with the help of protocl View inputs so VM can make call and tell view to update it self

        homeVC.bindWithVM(vm: homeVM) // bind Viewmodel to view
        
        self.navigationController?.setViewControllers([homeVC], animated: false)
    }
    
    func eventOccured(event: Event) {
        switch event {
        case .moveToContactDetailView(let contact):
            let detailCoordinator = ContactDetailCoordinator(nav: self.navigationController!, contact: contact)
            detailCoordinator.delegate = self
            detailCoordinator.start()
        case .updateContactListWith(_):
            break
        }
    }
}

extension HomeCoordinator: NavigatePrevious {
    func navigateBack(data: Contact) {
        homevM?.updateItem(contact: data)
    }
}
