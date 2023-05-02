//
//  HomeApiLoader.swift
//  iCarAsia
//
//  Created by Afroz Zaheer on 01/05/2023.
//

import Foundation

class HomeApiLoader: Requestable, LocalJsonFileReadable {

    static var baseURL: String { return "mock" }
    typealias T = [Contact]
    
    func request(params: [String : Any]?, api: URL?, result: @escaping (Result<[Contact], NetworkError>) -> Void) {
        let jsonFileName = "data"
        if let data = getData(jsonFileName: jsonFileName) {
            do {
                let decoded = try  JSONDecoder().decode([Contact].self, from: data)
                
                result(.success(decoded))
                
            } catch { print(error) }
        }
        else {
            result(.failure(NetworkError.readError))
        }
    }
}
