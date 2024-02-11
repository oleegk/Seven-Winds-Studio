//
//  RegistrationModuleBuilder.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import UIKit

class RegistrationModuleBuilder {
    static func build() -> RegistrationViewController {
        let interactor = RegistrationInteractor()
        let router = RegistrationRouter()
        let presenter = RegistrationPresenter(interactor: interactor, router: router)
        let viewController = RegistrationViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
