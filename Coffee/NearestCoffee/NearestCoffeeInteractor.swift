//
//  NearestCoffeeInteractor.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import UIKit


protocol NearestCoffeeInteractorProtocol: AnyObject {
    func numberOfCell() -> Int
    func returnLocation() -> Location
    func getIDLocation(index: Int, completion: @escaping (LocationID) -> ())
    func requestMenuByID(id: Int, completion: @escaping (LocationID) -> ())
    func returnToken() -> String

}

class NearestCoffeeInteractor {
    weak var presenter: NearestCoffeePresenterProtocol?
    
    var location: Location
    var token: AuthModel
    var service = ServiceLocationID()
    
    init(location: Location, token: AuthModel) {
        self.location = location
        self.token = token
    }
}


extension NearestCoffeeInteractor: NearestCoffeeInteractorProtocol {
    func numberOfCell() -> Int {
        return location.count
    }
    
    func returnLocation() -> Location {
        return location
    }
    
    func getIDLocation(index: Int, completion: @escaping (LocationID) -> ()) {
        let id = location[index].id
        requestMenuByID(id: id) { menu in
            completion(menu)
        }
    }
    
    func requestMenuByID(id: Int, completion: @escaping (LocationID) -> ()) {
        service.setupRequestLocation(token: token.token, id: id) { menu in
            completion(menu)
        }
    }
    
    func returnToken() -> String {
        return token.token
    }
}
