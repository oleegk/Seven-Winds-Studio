//
//  MenuViewController.swift
//  Coffee
//
//  Created by Олег Ковалев on 07.02.2024.
//

import UIKit

protocol MenuViewProtocol: AnyObject {
    func getArrayMenuModel()
}


class MenuViewController: UIViewController {
    var presenter: MenuPresenterProtocol?
    
    var arrayModelMenu: [MenuCellModel] = []
    
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    
    private lazy var goToPayButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 338, height: 48))
        button.backgroundColor = Constants.Colors.darkBrown
        button.layer.cornerRadius = 23
        button.clipsToBounds = true
        button.setTitle("Перейти к оплате", for: .normal)
        button.contentVerticalAlignment = .center
        button.titleLabel?.font = Constants.Fonts.SFUIDisplayBold700_18
        button.setTitleColor(Constants.Colors.lightBrownOne, for: .normal)
        button.addTarget(self, action: #selector(didTapGoToPayButton), for: .touchUpInside)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavBarAndItem()
        getArrayMenuModel()
    }
    
    
    func getArrayMenuModel() {
        arrayModelMenu = (presenter?.getArrayMenuModel()) ?? []
    }

    
    private func setupNavBarAndItem() {
        let titleLabel = UILabel()
        titleLabel.text = "Меню"
        titleLabel.font = Constants.Fonts.SFUIDisplayBold700_18
        titleLabel.textColor = Constants.Colors.brown

        navigationItem.titleView = titleLabel
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.Colors.brown]
        navigationController?.navigationBar.tintColor = Constants.Colors.brown
    }
    
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(goToPayButton)
        goToPayButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(35)
            make.height.equalTo(48)
            make.left.equalToSuperview().inset(19)
            make.right.equalToSuperview().inset(19)
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: "MenuCellIdentifier")
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.left.equalToSuperview().inset(16)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalTo(goToPayButton.snp.top).inset(-20)
        }
    }
    
    
    @objc func didTapGoToPayButton() {
        presenter?.didTapGoToPayButton(arrayMenuModel: arrayModelMenu)
    }
}


extension MenuViewController: MenuViewProtocol {}

extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayModelMenu.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCellIdentifier", for: indexPath) as! MenuCell
        
        cell.configure(model: arrayModelMenu[indexPath.row])
        cell.counterChangedHandler = { counter in
            self.arrayModelMenu[indexPath.row].counter = counter
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165, height: 205)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
