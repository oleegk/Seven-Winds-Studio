//
//  MapInteractor.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import Foundation

protocol MapInteractorProtocol: AnyObject {
    func requestMenuByID(id: Int, completion: @escaping (LocationID) -> ())
}

class MapInteractor {
    weak var presenter: MapPresenterProtocol?
    var service = ServiceLocationID()
    
    var token: String
    
    init(token: String) {
        self.token = token
    }
    
}


extension MapInteractor: MapInteractorProtocol {
    func requestMenuByID(id: Int, completion: @escaping (LocationID) -> ()) {
        service.setupRequestLocation(token: token, id: id) { menu in
            completion(menu)
        }
    }
}
