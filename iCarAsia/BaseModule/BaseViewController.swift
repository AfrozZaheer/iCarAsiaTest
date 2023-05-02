//
//  BaseViewController.swift
//  iCarAsia
//
//  Created by Afroz Zaheer on 01/05/2023.
//

import UIKit

protocol ViewModel {
    var coordinator: Coordinator? {get set}
}

class BaseViewController: UIViewController, Coordinating {
    func bindWithVM(vm: ViewModel) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
