//
//  ServiceLocation.swift
//  Coffee
//
//  Created by Олег Ковалев on 08.02.2024.
//

import Foundation
import Alamofire

// MARK: - LocationElement
struct LocationElement: Codable {
    let id: Int
    let name: String
    let point: Point
}

// MARK: - Point
struct Point: Codable {
    let latitude, longitude: String
}

typealias Location = [LocationElement]

class ServiceLocation {

    func setupRequestLocation(token: String, completion: @escaping (Location) -> ()) {
        let urlString = "http://147.78.66.203:3210/locations"
        let headers: HTTPHeaders = ["accept": "application/json", "Authorization": "Bearer \(token)"]

        AF.request(urlString, method: .get, headers: headers).responseDecodable(of: Location.self) { response in
            switch response.result {
                case .success(let value):
                    completion(value)
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
            }
        }
    }

}



