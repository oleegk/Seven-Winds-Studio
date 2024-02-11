//
//  MapRouter.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import Foundation

protocol MapRouterProtocol: AnyObject {
    func openMenuScreen(menu: LocationID)
}

class MapRouter {
    weak var viewController: MapViewController?
    
    func openMenuScreen(menu: LocationID) {
        let vc = MenuModuleBuilder.build(menu: menu)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}


extension MapRouter: MapRouterProtocol {}
