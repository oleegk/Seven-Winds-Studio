//
//  MapViewController.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import UIKit
import YandexMapsMobile

protocol MapViewProtocol: AnyObject {
    func didTapOnPlaceMark(placemark: YMKPlacemarkMapObject)
}


class MapViewController: UIViewController {

    var presenter: MapPresenterProtocol?

    private var mapView: YMKMapView!
    private var map: YMKMap!


    private lazy var mapObjectTapListener: YMKMapObjectTapListener = {
        let listener =  MapObjectTapListener(controller: self)
        listener.completion = { [weak self] placemark in
            self?.didTapOnPlaceMark(placemark: placemark)
        }
        return listener
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        setupView()
        setupNavBarAndItem()

        move()
        addPlacemarks(model: presenter?.location ?? Location())
    }


    private func setupView() {
        view.backgroundColor = .white

        mapView = YMKMapView()
        view.addSubview(mapView)
        map = mapView.mapWindow.map

        mapView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    private func setupNavBarAndItem() {
        let titleLabel = UILabel()
        titleLabel.text = "Карта"
        titleLabel.font = Constants.Fonts.SFUIDisplayBold700_18
        titleLabel.textColor = Constants.Colors.brown

        navigationItem.titleView = titleLabel
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.Colors.brown]
        navigationController?.navigationBar.tintColor = Constants.Colors.brown
    }

    private func move(to cameraPosition: YMKCameraPosition = Const.cameraPosition) {
        map.move(with: cameraPosition, animation: YMKAnimation(type: .smooth, duration: 1.5))
    }

    func addPlacemarks(model: Location) {
        print(model)
        model.forEach { location in
            let image = UIImage(named: "coffeeLabel")!
            let placemark = map.mapObjects.addPlacemark()
            placemark.geometry = YMKPoint(latitude: Double(location.point.latitude) ?? 0.0, longitude: Double(location.point.longitude) ?? 0.0)
            placemark.setIconWith(image)

            placemark.setTextWithText(
                location.name,
                style: YMKTextStyle(
                    size: 11.0,
                    color: Constants.Colors.brown,
                    outlineColor: .white,
                    placement: .bottom,
                    offset: 0.0,
                    offsetFromIcon: true,
                    textOptional: false
                )
            )
            placemark.isDraggable = false
            placemark.addTapListener(with: mapObjectTapListener)
        }
    }

    private enum Const {
        static let point = YMKPoint(latitude: 44.65, longitude: 44.65)
        static let cameraPosition = YMKCameraPosition(target: point, zoom: 9.3, azimuth: 150.0, tilt: 30.0)
    }
}


class MapObjectTapListener: NSObject, YMKMapObjectTapListener {
    
    var completion: ((YMKPlacemarkMapObject) -> Void)?
    
    
    init(controller: UIViewController) {
        self.controller = controller
    }

    
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        if let placemark = mapObject as? YMKPlacemarkMapObject {
            completion?(placemark)
        }
        return true
    }
    private weak var controller: UIViewController?
}




extension MapViewController: MapViewProtocol {
    
    func didTapOnPlaceMark(placemark: YMKPlacemarkMapObject) {
        presenter?.didTapOnPlaceMark(object: placemark)
    }
}




