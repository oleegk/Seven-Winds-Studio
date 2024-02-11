//
//  MenuPresenter.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import UIKit
import Alamofire

protocol MenuPresenterProtocol: AnyObject {
    func numberOfCell() -> Int
    func didTapGoToPayButton(arrayMenuModel: [MenuCellModel])
    func getArrayMenuModel() -> [MenuCellModel]
}

class MenuPresenter {
    weak var view: MenuViewProtocol?
    var router: MenuRouterProtocol
    var interactor: MenuInteractorProtocol
    
    var arrayMenuModel: [MenuCellModel] = []
    
    
    init(interactor: MenuInteractorProtocol, router: MenuRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}


extension MenuPresenter: MenuPresenterProtocol {
    func numberOfCell() -> Int {
        interactor.numberOfCell()
    }
    
    func didTapGoToPayButton(arrayMenuModel: [MenuCellModel]) {
        router.openOrderScreen(arrayModelMenu: arrayMenuModel)
    }
    
    func getArrayMenuModel() -> [MenuCellModel] {
        self.arrayMenuModel = interactor.arrayMenuModel
        return interactor.arrayMenuModel
    }
}
