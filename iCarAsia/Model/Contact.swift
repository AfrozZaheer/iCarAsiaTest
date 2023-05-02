//
//  Contact.swift
//  iCarAsia
//
//  Created by Afroz Zaheer on 01/05/2023.
//

import Foundation

class Contact: Codable {
    var id: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var phone: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "firstName"
        case lastName = "lastName"
        case email = "email"
        case phone = "phone"
    }
    
    init(id: String?, firstName: String?, lastName: String?, email: String?, phone: String?) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
    }
}

extension Contact: Equatable {
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.id == rhs.id
    }
}
