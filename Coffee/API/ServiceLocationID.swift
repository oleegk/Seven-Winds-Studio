//
//  ServiceLocationID.swift
//  Coffee
//
//  Created by Олег Ковалев on 09.02.2024.
//

import Foundation
import Alamofire

struct LocationIDElement: Codable {
    let id: Int
    let name, imageURL: String
    let price: Int
}

typealias LocationID = [LocationIDElement]


class ServiceLocationID {
    func setupRequestLocation(token: String, id: Int, completion: @escaping (LocationID) -> ()) {
        let urlString = "http://147.78.66.203:3210/location/\(id)/menu"
        let headers: HTTPHeaders = ["accept": "application/json", "Authorization": "Bearer \(token)"]

        AF.request(urlString, method: .get, headers: headers).responseDecodable(of: LocationID.self) { response in
            switch response.result {
                case .success(let value):
                    completion(value)
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
            }
        }
    }
}
