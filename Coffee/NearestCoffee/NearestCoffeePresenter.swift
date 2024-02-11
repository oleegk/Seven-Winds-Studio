//
//  NearestCoffeePresenter.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import Foundation

protocol NearestCoffeePresenterProtocol: AnyObject {
    func numberOfCell() -> Int
    func cellPressed(index: Int)
    func didTapOnMapButton()
    func returnCellModel() -> [CoffeeCellModel]

}


class NearestCoffeePresenter {
    weak var view: NearestCoffeeViewProtocol?
    var router: NearestCoffeeRouterProtocol
    var interactor: NearestCoffeeInteractorProtocol
    var cellModel: [CoffeeCellModel]
    
    init(interactor: NearestCoffeeInteractorProtocol, router: NearestCoffeeRouterProtocol, cellModel: [CoffeeCellModel]) {
        self.interactor = interactor
        self.router = router
        self.cellModel = cellModel
    }
}

extension NearestCoffeePresenter: NearestCoffeePresenterProtocol {
    func numberOfCell() -> Int {
        interactor.numberOfCell()
    }
    
    
    func cellPressed(index: Int) {
        interactor.getIDLocation(index: index) { menu in
            self.router.openMenuScreen(menu: menu)
        }
    }
    
    func didTapOnMapButton() {
        let location = interactor.returnLocation()
        let token = interactor.returnToken()
        router.openMapScreen(location: location, token: token)
    }
    
    func returnCellModel() -> [CoffeeCellModel] {
        return cellModel
    }
}
