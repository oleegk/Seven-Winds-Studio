//
//  MenuRouter.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import Foundation

protocol MenuRouterProtocol: AnyObject {
    func openOrderScreen(arrayModelMenu: [MenuCellModel])
}


class MenuRouter {
    weak var viewController: MenuViewController?
    
    func openOrderScreen(arrayModelMenu: [MenuCellModel]) {
        let vc = OrderModuleBuilder.build(arrayModelMenu: arrayModelMenu)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}


extension MenuRouter: MenuRouterProtocol {
    
}
