//
//  OrderModuleBuilder.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import UIKit

class OrderModuleBuilder {
    static func build(arrayModelMenu: [MenuCellModel]) -> OrderViewController {
        let interactor = OrderInteractor(arrayModelMenu: arrayModelMenu)
        let router = OrderRouter()
        let presenter = OrderPresenter(interactor: interactor, router: router)
        let viewController = OrderViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
