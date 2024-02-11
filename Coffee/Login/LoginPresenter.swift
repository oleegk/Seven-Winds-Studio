//
//  LoginPresenter.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import Foundation
import CoreLocation

protocol LoginPresenterProtocol: AnyObject {
    func emailWasEntered(email: String)
    func passwordWasEntered(password: String)
    func didTapLoginButton()
}


class LoginPresenter {
    weak var view: LoginViewProtocol?
    var router: LoginRouterProtocol
    var interactor: LoginInteractorProtocol
    var userLocation: CLLocation
    
    var coffeeCellModelArray: [CoffeeCellModel] = []
    
    init(interactor: LoginInteractorProtocol, router: LoginRouterProtocol, userLocation: CLLocation) {
        self.interactor = interactor
        self.router = router
        self.userLocation = userLocation
    }
}


extension LoginPresenter: LoginPresenterProtocol {
    
    func emailWasEntered(email: String) {
        interactor.emailWasEntered(email: email)
    }
    
    func passwordWasEntered(password: String) {
        interactor.passwordWasEntered(password: password)
    }
    
    func didTapLoginButton() {
        interactor.didTapLoginButton() { resultRequest in
            if resultRequest == .addingError {
                self.view?.alertIncorrectDataEntered()
            }
        } completion2: { model in
            self.setupRequestLocation(model: model)
        }
    }
    
    
    func setupRequestLocation(model: AuthModel) {
        interactor.setupRequestLocation(model: model) { location in
            self.distanceCalculation(locations: location)
            self.router.openNearestCoffeScreen(location: location, token: model, cellModel: self.coffeeCellModelArray)
        }
    }
    
    func distanceCalculation(locations: Location) {
        locations.forEach { location in
            let coordinatesLocation = CLLocation(latitude: Double(location.point.latitude) ?? 0.0,
                                           longitude: Double(location.point.longitude) ?? 0.0)
            
            
            let distance = userLocation.distance(from: coordinatesLocation)
            let distanceInKM = Int(distance / 1000)
            let model = CoffeeCellModel(name: location.name, distance: distanceInKM)
            self.coffeeCellModelArray.append(model)            
        }
    }
}
