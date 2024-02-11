//
//  MenuModuleBuilder.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import UIKit

class MenuModuleBuilder {
    static func build(menu: LocationID) -> MenuViewController {
        let interactor = MenuInteractor(menu: menu)
        let router = MenuRouter()
        let presenter = MenuPresenter(interactor: interactor, router: router)
        let viewController = MenuViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
