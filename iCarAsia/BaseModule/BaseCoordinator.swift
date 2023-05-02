//
//  BaseCoordinator.swift
//  iCarAsia
//
//  Created by Afroz Zaheer on 01/05/2023.
//

import Foundation
import UIKit

enum Event {
    case moveToContactDetailView(contact: Contact?)
    case updateContactListWith(contact: Contact)
}

protocol NavigatePrevious: AnyObject {
    
    func navigateBack(data: Contact)
}

protocol Coordinator {
    
    var delegate: NavigatePrevious? {get set}
    
    var navigationController: UINavigationController? {get set}
    
    func start()
    
    func eventOccured(event: Event)
}

protocol Coordinating: AnyObject {
    func bindWithVM(vm: ViewModel)
}

final class BaseCoordinator: Coordinator {
    weak var delegate: NavigatePrevious?
    
    var navigationController: UINavigationController?
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigation = UINavigationController()
        let homeCoordinator = HomeCoordinator(nav: navigation)
        homeCoordinator.start()
        
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
    
    func eventOccured(event: Event) {}
    
    
}
