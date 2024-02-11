//
//  RegistrationInteractor.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import Foundation


protocol RegistrationInteractorProtocol: AnyObject {
    func didEnterEmail(_ email: String)
    func didEnterPassword(_ password: String)
    func didEnterRepeatPassword(_ password: String, completion: @escaping (Bool) -> ())
    func sendingData(completion: @escaping (ResultRequest) -> ())
}

class RegistrationInteractor {
    weak var presenter: RegistrationPresenterProtocol?
    var service = ServiceLoginAndAuth()
    
    var email: String?
    var password: String?
    var repeatPassword: String?
}



extension RegistrationInteractor: RegistrationInteractorProtocol {
    
    func didEnterEmail(_ email: String) {
        self.email = email
    }
    func didEnterPassword(_ password: String) {
        self.password = password
    }
    func didEnterRepeatPassword(_ password: String, completion: @escaping (Bool) -> ()) {
        self.repeatPassword = password
        self.password == password ? completion(true) : completion(false)
    }
    
    
    func sendingData(completion: @escaping (ResultRequest) -> ()) {
        guard let email = email,
              let password = password else { return }
        if password == self.repeatPassword {
            service.setupRequestAuth(login: email, password: password, requestType: .register) { resultRequest in
                completion(resultRequest)
            } completion2: { model in }
        } else {
            print("Пароли не совпадают")
        }
    }
}
