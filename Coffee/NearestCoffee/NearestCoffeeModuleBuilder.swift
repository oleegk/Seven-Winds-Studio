//
//  NearestCoffeeModuleBuilder.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import UIKit

class NearestCoffeeModuleBuilder {
    static func build(location: Location, token: AuthModel, cellModel: [CoffeeCellModel]) -> NearestCoffeeViewController {
        let interactor = NearestCoffeeInteractor(location: location, token: token)
        let router = NearestCoffeeRouter()
        let presenter = NearestCoffeePresenter(interactor: interactor, router: router, cellModel: cellModel)
        let viewController = NearestCoffeeViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
