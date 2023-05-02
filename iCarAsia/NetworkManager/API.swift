//
//  API.swift
//  iCarAsia
//
//  Created by Afroz Zaheer on 01/05/2023.
//

import Foundation

protocol LocalJsonFileReadable {
    func getData(jsonFileName: String) -> Data?
}

extension LocalJsonFileReadable {
    func getData(jsonFileName: String) -> Data? {
        if let path = Bundle.main.path(forResource: jsonFileName, ofType: "json") {
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return data
        }
        return nil
    }
}

