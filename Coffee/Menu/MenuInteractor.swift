//
//  MenuInteractor.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import UIKit

protocol MenuInteractorProtocol: AnyObject {
    func numberOfCell() -> Int
    func creatingArrayMenuModel(menu: LocationID)
    var arrayMenuModel: [MenuCellModel] { get set }

}

class MenuInteractor {
    weak var presenter: MenuPresenterProtocol?
    
    var menu: LocationID
    
    var arrayMenuModel: [MenuCellModel] = []


    
    init(menu: LocationID) {
        self.menu = menu
        creatingArrayMenuModel(menu: menu)
    }
}


extension MenuInteractor: MenuInteractorProtocol {
    func numberOfCell() -> Int {
        arrayMenuModel.count
    }
    
    func creatingArrayMenuModel(menu: LocationID) {
        menu.forEach { element in
            let model = MenuCellModel(id: element.id, name: element.name, price: element.price, imageUrl: element.imageURL)
            arrayMenuModel.append(model)
        }
    }
}
