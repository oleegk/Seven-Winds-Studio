//
//  NearestCoffeeRouter.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import Foundation

protocol NearestCoffeeRouterProtocol: AnyObject {
    func openMenuScreen(menu: LocationID)
    func openMapScreen(location: Location, token: String)
}

class NearestCoffeeRouter {
    weak var viewController: NearestCoffeeViewController?
    
    func openMenuScreen(menu: LocationID) {
        let vc = MenuModuleBuilder.build(menu: menu)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openMapScreen(location: Location, token: String) {
        let vc = MapModuleBuilder.build(location: location, token: token)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}


extension NearestCoffeeRouter: NearestCoffeeRouterProtocol {}
