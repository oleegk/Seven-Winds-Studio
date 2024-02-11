//
//  RegistrationRouter.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import Foundation
import CoreLocation

protocol RegistrationRouterProtocol: AnyObject {
    func openLoginScreen(userLocation: CLLocation)
}


class RegistrationRouter {
    weak var viewController: RegistrationViewController?
    
    func openLoginScreen(userLocation: CLLocation) {
        let vc = LoginModuleBuilder.build(userLocation: userLocation)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension RegistrationRouter: RegistrationRouterProtocol {}
