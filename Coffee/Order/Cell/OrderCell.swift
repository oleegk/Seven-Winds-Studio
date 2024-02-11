//
//  OrderCell.swift
//  Coffee
//
//  Created by Олег Ковалев on 10.02.2024.
//

import UIKit

class OrderCell: UICollectionViewCell {
        
    var model: MenuCellModel?
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 253, height: 21))
        label.text = "Coffee"
        label.font = Constants.Fonts.SFUIDisplayBold700_18
        label.textColor = Constants.Colors.brown
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 17))
        label.text = "200 руб"
        label.textColor = Constants.Colors.lightBrownTwo
        label.font = Constants.Fonts.SFUIDisplayMedium500_16
        return label
    }()
    
    private lazy var minusButton: UIButton = {
        let button = ExtendedHitAreaButton(type: .custom)
        button.setTitle("-", for: .normal)
        button.setTitleColor(Constants.Colors.brown, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 35, weight: .light)
        button.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 17))
        label.text = "0"
        label.font = Constants.Fonts.SFUIDisplayBold700_18
        label.textColor = Constants.Colors.brown
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = ExtendedHitAreaButton(type: .custom)
        button.setTitle("+", for: .normal)
        button.setTitleColor(Constants.Colors.brown, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .light)
        button.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        return button
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(plusButton)
        addSubview(countLabel)
        addSubview(minusButton)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCell()
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(plusButton)
        addSubview(countLabel)
        addSubview(minusButton)
    }
    
    
    @objc func didTapPlusButton() {
        model?.counter += 1
        countLabel.text = "\(String(describing: model?.counter ?? 0))"
    }
    
    @objc func didTapMinusButton() {
        if model?.counter ?? 0 >= 1 {
            model?.counter -= 1
            countLabel.text = "\(String(describing: model?.counter ?? 0))"
        }
    }
    
    func configure(model: MenuCellModel) {
        self.model = model
        self.nameLabel.text = model.name
        self.priceLabel.text = "\(model.price) руб"
        self.countLabel.text = "\(model.counter)"
    }
    
    

    private func setupViews() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.left.equalToSuperview().inset(12)
            make.width.equalTo(253)
            make.height.equalTo(21)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(-5)
            make.left.equalToSuperview().inset(14)
            make.width.equalTo(140)
            make.height.equalTo(21)
        }
        
        plusButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(20)
            make.width.height.equalTo(24)

        }
        
        countLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(plusButton.snp.left).inset(-3)
            make.width.height.equalTo(20)
        }
        
        minusButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(countLabel.snp.left).inset(-10)
            make.width.height.equalTo(24)
        }
    }
    
    func setupCell() {
        self.backgroundColor = Constants.Colors.lightBrownOne
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 3
    }
}
