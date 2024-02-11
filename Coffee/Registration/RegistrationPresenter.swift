//
//  RegistrationPresenter.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import UIKit
import CoreLocation

protocol RegistrationPresenterProtocol: AnyObject {
    func didTapRegistrationButton()
    
    func didEnterEmail(_ email: String)
    func didEnterPassword(_ password: String)
    func didEnterRepeatPassword(_ password: String)
    
    func registrationButtonPressed()
}


class RegistrationPresenter {
    weak var view: RegistrationViewProtocol?
    var router: RegistrationRouterProtocol
    var interactor: RegistrationInteractorProtocol
    
    var userLocation: CLLocation?
    let locationManager = LocationManager()
    
    
    init(interactor: RegistrationInteractorProtocol, router: RegistrationRouterProtocol) {
        self.interactor = interactor
        self.router = router
        currentCoordinates()
    }
    
    
    func currentCoordinates() {
        locationManager.coordinatesClosure = { currentCoordinates in
            let userLocation = CLLocation(latitude: currentCoordinates.latitude, longitude: currentCoordinates.longitude)
            self.userLocation = userLocation
        }
    }
}


extension RegistrationPresenter: RegistrationPresenterProtocol {
    func didTapRegistrationButton() {
        interactor.sendingData() { resultRequest in
            switch resultRequest {
            case .userAdded:
                self.view?.alertUserAdded()
            case .addingError:
                self.view?.alertUserHasAlreadyBeenAdded()
            }
        }
    }
    
    func didEnterEmail(_ email: String) {
        interactor.didEnterEmail(email)
    }
    func didEnterPassword(_ password: String) {
        interactor.didEnterPassword(password)
    }
    func didEnterRepeatPassword(_ password: String) {
        interactor.didEnterRepeatPassword(password) { passwordsIsEqual in
            if !passwordsIsEqual {
                self.view?.alertPasswordMismatch()
            }
        }
    }
    
    
    func registrationButtonPressed() {
        if let userLocation = userLocation {
            router.openLoginScreen(userLocation: userLocation)
        }
    }
}
