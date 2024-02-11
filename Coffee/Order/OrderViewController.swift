//
//  OrderViewController.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import UIKit

protocol OrderViewProtocol: AnyObject {
    
}

class OrderViewController: UIViewController {
    var presenter: OrderPresenterProtocol?
    
    private lazy var payButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 338, height: 48))
        button.backgroundColor = Constants.Colors.darkBrown
        button.layer.cornerRadius = 23
        button.clipsToBounds = true
        button.setTitle("Оплатить", for: .normal)
        button.contentVerticalAlignment = .center
        button.titleLabel?.font = Constants.Fonts.SFUIDisplayBold700_18
        button.setTitleColor(Constants.Colors.lightBrownOne, for: .normal)
        button.addTarget(self, action: #selector(didTapPayButton), for: .touchUpInside)
        return button
    }()
    
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    
    private lazy var thankLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 349, height: 87))
        label.text = "Время ожидания заказа \n15 минут! \nСпасибо, что выбрали нас!"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = Constants.Fonts.SFUIDisplayMedium500_24
        label.textColor = Constants.Colors.brown
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavBarAndItem()
    }
    
    private func setupNavBarAndItem() {
        let titleLabel = UILabel()
        titleLabel.text = "Ваш заказ"
        titleLabel.font = Constants.Fonts.SFUIDisplayBold700_18
        titleLabel.textColor = Constants.Colors.brown

        navigationItem.titleView = titleLabel
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.Colors.brown]
        navigationController?.navigationBar.tintColor = Constants.Colors.brown
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(payButton)
        payButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(35)
            make.height.equalTo(48)
            make.left.equalToSuperview().inset(16)
            make.right.equalToSuperview().inset(16)
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(OrderCell.self, forCellWithReuseIdentifier: "orderCellIdentifier")
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.bottom.equalTo(payButton.snp.top).inset(-20)
        }
        
        view.addSubview(thankLabel)
        thankLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(486)
            make.height.equalTo(87)
            make.left.equalToSuperview().inset(13)
            make.right.equalToSuperview().inset(13)
        }

    }
    
    
    @objc func didTapPayButton() {
        if presenter?.returnModelsMenu().count == 0 {
            AlertPresenter.present(from: self, with: "Заказ пуст")
        } else {
            AlertPresenter.present(from: self, with: "Оплачено!")
        }

    }
}


extension OrderViewController: OrderViewProtocol {}

extension OrderViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfCell() ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "orderCellIdentifier", for: indexPath) as! OrderCell
        if let arrayModelsMenu = presenter?.returnModelsMenu() {
            cell.configure(model: arrayModelsMenu[indexPath.row])
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 10, height: 71)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
}
