//
//  MapModuleBuilder.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import UIKit

class MapModuleBuilder {
    static func build(location: Location, token: String) -> MapViewController {
        let interactor = MapInteractor(token: token)
        let router = MapRouter()
        let presenter = MapPresenter(interactor: interactor, router: router, location: location)
        let viewController = MapViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
