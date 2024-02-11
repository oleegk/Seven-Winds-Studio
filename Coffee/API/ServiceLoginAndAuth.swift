//
//  Service.swift
//  Coffee
//
//  Created by Олег Ковалев on 08.02.2024.
//

import Foundation
import Alamofire

struct AuthModel: Decodable {
    let token: String
    let tokenLifetime: Int
}

enum AuthType: String {
    case login
    case register
}

enum ResultRequest {
    case userAdded
    case addingError
}


class ServiceLoginAndAuth {
    func setupRequestAuth(login: String, password: String, requestType: AuthType, completion: @escaping (ResultRequest) -> (), completion2: @escaping (AuthModel) -> ()) {
        let urlString = "http://147.78.66.203:3210/auth/\(requestType.rawValue)"
        let parameters: [String: Any] = ["login": login, "password": password]
        
        AF.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseDecodable(of: AuthModel.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.userAdded)
                    completion2(value)
                case .failure(_):
                    completion(.addingError)
            }
        }
    }
}

