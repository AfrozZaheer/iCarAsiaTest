//
//  BaseApiManager.swift
//  iCarAsia
//
//  Created by Afroz Zaheer on 01/05/2023.
//

import Foundation

enum NetworkError: Error {
    case readError
}

protocol Requestable {
    associatedtype T

    static var baseURL: String { get }
    func request(params: [String: Any]?, api: URL?, result: @escaping (Result<T, NetworkError>) -> Void)
}
