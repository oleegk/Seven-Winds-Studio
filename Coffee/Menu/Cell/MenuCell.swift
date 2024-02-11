//
//  MenuCell.swift
//  Coffee
//
//  Created by Олег Ковалев on 09.02.2024.
//

import UIKit
import SnapKit

class MenuCell: UICollectionViewCell {
    var presenter: MenuPresenterProtocol?
    
    var model: MenuCellModel?
    
    var counterChangedHandler: ((Int) -> Void)?
    
    func updateCounter(counter: Int) {
        counterChangedHandler?(counter)
    }

    private lazy var coffeeImage: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 165, height: 137))
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 84, height: 18))
        label.textColor = Constants.Colors.lightBrownTwo
        label.font = Constants.Fonts.SFUIDisplayMedium500_15
        return label
    }()
    
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 17))
        label.textColor = Constants.Colors.brown
        label.font = Constants.Fonts.SFUIDisplayBold700_14
        return label
    }()
    
    
    private lazy var minusButton: UIButton = {
        let button = ExtendedHitAreaButton(type: .custom)
        button.setTitle("-", for: .normal)
        button.setTitleColor(Constants.Colors.lightBrownOne, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 40, weight: .light)
        button.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var counterLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 17))
        label.text = "0"
        label.font = Constants.Fonts.SFUIDisplayThin400_14
        label.textColor = Constants.Colors.brown
        
        return label
    }()
    
    
    private lazy var plusButton: UIButton = {
        let button = ExtendedHitAreaButton(type: .custom)
        button.setTitle("+", for: .normal)
        button.setTitleColor(Constants.Colors.lightBrownOne, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .light)
        button.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        return button
    }()
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        addSubview(coffeeImage)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(minusButton)
        addSubview(plusButton)
        addSubview(counterLabel)
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCell()
        addSubview(coffeeImage)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(minusButton)
        addSubview(counterLabel)
        setupView()
    }
    
    
    @objc func didTapPlusButton() {
        guard var model = model else { return }
        model.counter += 1
        counterLabel.text = "\(model.counter)"
        self.model = model
        
        updateCounter(counter: model.counter)
        
    }
    
    @objc func didTapMinusButton() {
        guard var model = model else { return }
        if model.counter >= 1 {
            model.counter -= 1
            counterLabel.text = "\(model.counter)"
            self.model = model
            
            updateCounter(counter: model.counter)
        }
    }
    
    
    
    
    func setupView() {
        coffeeImage.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(137)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.top.equalTo(coffeeImage.snp.bottom).inset(-10)
            make.height.equalTo(18)
            make.width.equalTo(140)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.top.equalTo(nameLabel.snp.bottom).inset(-10)
            make.height.equalTo(17)
            make.width.equalTo(70)
        }
        
        minusButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(55)
            make.centerY.equalTo(priceLabel.snp.centerY)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        
        counterLabel.snp.makeConstraints { make in
            make.left.equalTo(minusButton.snp.right).inset(-5)
            make.centerY.equalTo(priceLabel.snp.centerY)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        
        plusButton.snp.makeConstraints { make in
            make.left.equalTo(counterLabel.snp.right).inset(5)
            make.centerY.equalTo(priceLabel.snp.centerY)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
    }
    
    func setupCell() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 3
        
    }
    
    
    func configure(model: MenuCellModel) {

        self.model = model
        self.nameLabel.text = model.name
        self.priceLabel.text = "\(model.price) руб"
        DispatchQueue.global(qos: .userInteractive).async {
            if let data = try? Data(contentsOf: (URL(string: model.imageUrl) ?? URL(string: ""))!) {
                DispatchQueue.main.async {
                let view = UIImage(data: data)
                self.coffeeImage.image = view
                }
            }
        }
    }
}



class ExtendedHitAreaButton: UIButton {
    private var hitAreaEdgeInsets = UIEdgeInsets(top: -12, left: -12, bottom: -12, right: -12)

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let extendedHitArea = bounds.inset(by: hitAreaEdgeInsets)
        return extendedHitArea.contains(point)
    }
}

