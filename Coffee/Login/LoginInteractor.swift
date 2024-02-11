//
//  LoginInteractor.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import Foundation
import CoreLocation

protocol LoginInteractorProtocol: AnyObject {
    func emailWasEntered(email: String)
    func passwordWasEntered(password: String)
    func didTapLoginButton(completion: @escaping (ResultRequest) -> (), completion2: @escaping (AuthModel) -> ())
    func setupRequestLocation(model: AuthModel, completion: @escaping (Location) -> ())
}

class LoginInteractor {
    weak var presenter: LoginPresenterProtocol?
    var serviceLoginAndAuth = ServiceLoginAndAuth()
    var serviceLocation = ServiceLocation()
    
    var email: String?
    var password: String?
    
    var token: String?
    var tokenLifetime: Int?
    
    var userLocation: CLLocation
    var locations: Location?
    
    var coffeeCellModelArray: [CoffeeCellModel] = []
    
    
    init(userLocation: CLLocation) {
        self.userLocation = userLocation
    }
}


extension LoginInteractor: LoginInteractorProtocol {

    
    func emailWasEntered(email: String) {
        self.email = email
    }
    
    func passwordWasEntered(password: String) {
        self.password = password
    }
    
    
    func didTapLoginButton(completion: @escaping (ResultRequest) -> (),
                           completion2: @escaping (AuthModel) -> ()) {
        guard let email = self.email, let password = self.password else { return }
        
        serviceLoginAndAuth.setupRequestAuth(login: email,
                                             password: password,
                                             requestType: .login) { resultRequest in
        completion(resultRequest)
        }
        
        completion2: { model in
            self.token = model.token
            self.tokenLifetime = model.tokenLifetime
            completion2(model)
        }   
    }
    
    
    func setupRequestLocation(model: AuthModel, completion: @escaping (Location) -> ()) {
        self.serviceLocation.setupRequestLocation(token: model.token) { location in
            self.locations = location
            completion(location)
        }
    }
}
