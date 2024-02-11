//
//  OrderRouter.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import Foundation

protocol OrderRouterProtocol: AnyObject {}

class OrderRouter {
    weak var viewController: OrderViewController?
}


extension OrderRouter: OrderRouterProtocol {}
