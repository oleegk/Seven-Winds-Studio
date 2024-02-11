//
//  NearestCoffeeViewController.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import UIKit

protocol NearestCoffeeViewProtocol: AnyObject {
    
}

class NearestCoffeeViewController: UIViewController {
    
    var presenter: NearestCoffeePresenterProtocol?
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var onMapButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 338, height: 48))
        button.backgroundColor = Constants.Colors.darkBrown
        button.layer.cornerRadius = 23
        button.clipsToBounds = true
        button.setTitle("На карте", for: .normal)
        button.contentVerticalAlignment = .center
        button.titleLabel?.font = Constants.Fonts.SFUIDisplayBold700_18
        button.setTitleColor(Constants.Colors.lightBrownOne, for: .normal)
        button.addTarget(self, action: #selector(didTapOnMapButton), for: .touchUpInside)
        return button
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarAndItem()
        setupView()
    }
    
    
    private func setupNavBarAndItem() {
        let titleLabel = UILabel()
        titleLabel.text = "Ближайшие кофейни"
        titleLabel.font = Constants.Fonts.SFUIDisplayBold700_18
        titleLabel.textColor = Constants.Colors.brown

        navigationItem.titleView = titleLabel

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.Colors.brown]
        navigationController?.navigationBar.tintColor = Constants.Colors.brown
    }
    
    
    private func setupView() {
        view.backgroundColor = .white

        view.addSubview(onMapButton)
        onMapButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(35)
            make.height.equalTo(48)
            make.left.equalToSuperview().inset(19)
            make.right.equalToSuperview().inset(19)
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CoffeeCell.self, forCellWithReuseIdentifier: "nearestCoffeeCellIdentifier")
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.bottom.equalTo(onMapButton.snp.top).inset(-20)
        }
    }
    
    
    @objc func didTapOnMapButton() {
        print("didTapOnMapButton")
        presenter?.didTapOnMapButton()
    }
}


extension NearestCoffeeViewController: NearestCoffeeViewProtocol {}

extension NearestCoffeeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfCell() ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nearestCoffeeCellIdentifier", for: indexPath) as! CoffeeCell
        
        if let coffeeCellModelArray = presenter?.returnCellModel() {
            cell.configure(model: coffeeCellModelArray[indexPath.row])
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 10, height: 71)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.cellPressed(index: indexPath.row)
    }
}
