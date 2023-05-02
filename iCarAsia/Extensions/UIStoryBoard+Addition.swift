//
//  UIStoryBoard+Addition.swift
//  iCarAsia
//
//  Created by Afroz Zaheer on 01/05/2023.
//

import Foundation
import UIKit

enum StoryBoardsName: String {
    case home = "HomeView"
    case contactDetail = "ContactDetail"
}

extension UIStoryboard {
    
    static let home = UIStoryboard(name: StoryBoardsName.home.rawValue, bundle: nil)
    static let contactDetail = UIStoryboard(name: StoryBoardsName.contactDetail.rawValue, bundle: nil)
}
