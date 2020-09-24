//
//  UnlockCell.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/11.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class UnlockCell: XWTableViewCell {
    
    let newPriceLabel = XWLabel()
    let oldPriceLabel = XWLabel()
    fileprivate let typeLabel = XWLabel()
    fileprivate let priceLabel = XWLabel()
    let discountLabel = XWLabel()
    let newUserLabel = XWLabel()
    
    let selectView = XWImageView()
    
    var model : UnlockModel! {
        didSet{
            updateData()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        newPriceLabel.text = "98.0"
        newPriceLabel.textColor = UIColor.white
        newPriceLabel.setFont(size: 18, isBold: true)
        self.contentView.addSubview(newPriceLabel)
        
        oldPriceLabel.attributedText = "188.0".xw_addDeleteline()
        oldPriceLabel.textColor = UIColor.white
        oldPriceLabel.setFont(size: 16, isBold: true)
        self.contentView.addSubview(oldPriceLabel)
        
        typeLabel.text = monthCard
        typeLabel.textColor = UIColor.white
        typeLabel.setFont(size: 16)
        self.contentView.addSubview(typeLabel)
        
        priceLabel.text = only + "3.3" + dayAndYuan
        priceLabel.textColor = UIColor.Theme.golden
        priceLabel.textAlignment = .center
        priceLabel.setFont(size: 14)
        priceLabel.setCornerRadius(15)
        priceLabel.setborder(size: 1, color: UIColor.Theme.golden)
        self.contentView.addSubview(priceLabel)
        
        discountLabel.text = "66" + discount
        discountLabel.textAlignment = .center
        discountLabel.backgroundColor = UIColor.rgb(255, 51, 53)
        discountLabel.setCornerRadius(10)
        discountLabel.textColor = UIColor.white
        discountLabel.setFont(size: 14)
        self.contentView.addSubview(discountLabel)
        
        newUserLabel.text = specialOffer
        newUserLabel.textAlignment = .center
        newUserLabel.backgroundColor = UIColor.rgb(60, 56, 44)
        newUserLabel.textColor = UIColor.Theme.golden
        newUserLabel.setFont(size: 14)
        newUserLabel.setCornerRadius(15)
        self.contentView.addSubview(newUserLabel)
        
        selectView.isHidden = true
        selectView.backgroundColor = UIColor.Theme.golden.withAlphaComponent(0.2)
        selectView.setborder(size: 2, color: UIColor.Theme.golden)
        selectView.setCornerRadius(5)
        self.contentView.addSubview(selectView)
        
        priceLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-30)
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        newPriceLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(priceLabel.snp.centerY).offset(-5)
            make.left.equalToSuperview().offset(30)
            make.width.greaterThanOrEqualTo(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        oldPriceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(newPriceLabel.snp.right).offset(5)
            make.centerY.equalTo(newPriceLabel)
            make.width.greaterThanOrEqualTo(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        typeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(newPriceLabel)
            make.top.equalTo(priceLabel.snp.centerY).offset(5)
            make.width.greaterThanOrEqualTo(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        discountLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(oldPriceLabel)
            make.left.equalTo(oldPriceLabel.snp.right).offset(5)
            make.width.equalTo(50)
            make.height.equalTo(20)
        }
        
        newUserLabel.snp.makeConstraints { (make) in
            make.left.equalTo(typeLabel.snp.right).offset(5)
            make.centerY.equalTo(typeLabel)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        selectView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10))
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func updateData() {
        
        priceLabel.text = only + (model.unit ?? "0.0") + dayAndYuan
        newPriceLabel.text = model.amount
        oldPriceLabel.attributedText = model.price?.xw_addDeleteline()
        typeLabel.text = model.name
        discountLabel.text = "66" + discount
    }
    
}
