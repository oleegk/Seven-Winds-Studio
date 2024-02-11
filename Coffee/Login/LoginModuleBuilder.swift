//
//  LoginModuleBuilder.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import UIKit
import CoreLocation

class LoginModuleBuilder {
    static func build(userLocation: CLLocation) -> LoginViewController {
        let interactor = LoginInteractor(userLocation: userLocation)
        let router = LoginRouter()
        let presenter = LoginPresenter(interactor: interactor, router: router, userLocation: userLocation)
        let viewController = LoginViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
