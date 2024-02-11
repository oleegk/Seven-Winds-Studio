//
//  OrderInteractor.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import Foundation

protocol OrderInteractorProtocol: AnyObject {
    func numberOfCell() -> Int
    func returnModelsMenu() -> [MenuCellModel]
}

class OrderInteractor {
    weak var presenter: OrderPresenterProtocol?
    
    var arrayModelMenu: [MenuCellModel]
    var arraySelectelModelMenu: [MenuCellModel] = []
    
    
    
    init(arrayModelMenu: [MenuCellModel]) {
        self.arrayModelMenu = arrayModelMenu
        selectionOfSelectedModels(models: arrayModelMenu)
    }
    
    func selectionOfSelectedModels(models: [MenuCellModel]) {
        models.forEach { model in
            if model.counter >= 1 {
                arraySelectelModelMenu.append(model)
            }
        }
    }
}


extension OrderInteractor: OrderInteractorProtocol {
    func numberOfCell() -> Int {
        return arraySelectelModelMenu.count
    }
    
    func returnModelsMenu() -> [MenuCellModel] {
        return arraySelectelModelMenu
    }
}
