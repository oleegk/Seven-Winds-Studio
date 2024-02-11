//
//  LoginRouter.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import Foundation

protocol LoginRouterProtocol: AnyObject {
    func openNearestCoffeScreen(location: Location, token: AuthModel, cellModel: [CoffeeCellModel])
}

class LoginRouter {
    weak var viewController: LoginViewController?
    
    func openNearestCoffeScreen(location: Location, token: AuthModel, cellModel: [CoffeeCellModel]) {
        let vc = NearestCoffeeModuleBuilder.build(location: location, token: token, cellModel: cellModel)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}


extension LoginRouter: LoginRouterProtocol {
    
}
