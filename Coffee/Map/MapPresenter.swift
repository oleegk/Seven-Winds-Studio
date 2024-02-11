//
//  MapPresenter.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import Foundation
import YandexMapsMobile

protocol MapPresenterProtocol: AnyObject {
    var location: Location { get set }
    func didTapOnPlaceMark(object: YMKPlacemarkMapObject)

}

class MapPresenter {
    weak var view: MapViewProtocol?
    var router: MapRouterProtocol
    var interactor: MapInteractorProtocol
    
    var location: Location
    
    init(interactor: MapInteractorProtocol, router: MapRouterProtocol, location: Location) {
        self.interactor = interactor
        self.router = router
        self.location = location
    }
}


extension MapPresenter: MapPresenterProtocol {
    func didTapOnPlaceMark(object: YMKPlacemarkMapObject) {
        location.forEach { location in
            if Double(location.point.latitude) == object.geometry.latitude && Double(location.point.longitude) == object.geometry.longitude {
                print("Работает")
                interactor.requestMenuByID(id: location.id) { menu in
                    self.router.openMenuScreen(menu: menu)
                }
            }
        }
    }
}
