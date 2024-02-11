//
//  OrderPresenter.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import Foundation

protocol OrderPresenterProtocol: AnyObject {
    func numberOfCell() -> Int
    func returnModelsMenu() -> [MenuCellModel]

}


class OrderPresenter {
    weak var view: OrderViewProtocol?
    var router: OrderRouterProtocol
    var interactor: OrderInteractorProtocol
    
    init(interactor: OrderInteractorProtocol, router: OrderRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}


extension OrderPresenter: OrderPresenterProtocol {
    func numberOfCell() -> Int {
        interactor.numberOfCell()
    }
    
    func returnModelsMenu() -> [MenuCellModel] {
        interactor.returnModelsMenu()
    }
}
