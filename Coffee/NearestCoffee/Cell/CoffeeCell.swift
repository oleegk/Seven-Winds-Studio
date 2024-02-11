//
//  CoffeeCell.swift
//  Coffee
//
//  Created by Олег Ковалев on 09.02.2024.
//

import UIKit

class CoffeeCell: UICollectionViewCell {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 253, height: 21))
        label.text = "кофейня"
        label.font = Constants.Fonts.SFUIDisplayBold700_18
        label.textColor = Constants.Colors.brown
        return label
    }()
    
    private lazy var distanceLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 140, height: 21))
        label.text = "? км от вас"
        label.font = Constants.Fonts.SFUIDisplayThin400_14
        label.textColor = Constants.Colors.lightBrownTwo
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        addSubview(nameLabel)
        addSubview(distanceLabel)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCell()
        addSubview(nameLabel)
        addSubview(distanceLabel)
    }
    
    
    
    func configure(model: CoffeeCellModel) {
        self.nameLabel.text = model.name
        self.distanceLabel.text = "\(model.distance) км от вас"
    }
    
    
    private func setupViews() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(14)
            make.left.equalToSuperview().inset(12)
            make.width.equalTo(253)
            make.height.equalTo(21)
        }
    
        distanceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(-4)
            make.left.equalToSuperview().inset(14)
            make.width.equalTo(140)
            make.height.equalTo(21)
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

