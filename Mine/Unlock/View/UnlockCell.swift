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
    let typeLabel = XWLabel()
    let priceLabel = XWLabel()
    let discountLabel = XWLabel()
    let newUserLabel = XWLabel()
    let confirmBtn = XWButton()
    
    let blackView = XWView()
    let bgView = XWImageView()
    
    var model : UnlockModel! {
        didSet{
            updateData()
        }
    }
    
    var isSelect = false {
        
        didSet{
            
            if isSelect {
                typeLabel.textColor = UIColor.Theme.goldenBlack
                newPriceLabel.backgroundColor = UIColor.Theme.goldenBlack
                newPriceLabel.textColor = UIColor.Theme.golden
            }else{
                typeLabel.textColor = UIColor.Theme.golden
                newPriceLabel.backgroundColor = UIColor.Theme.golden
                newPriceLabel.textColor = UIColor.Theme.goldenBlack
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        blackView.backgroundColor = UIColor.Theme.vip_bg
        self.contentView.addSubview(blackView)
        
        bgView.backgroundColor = UIColor.Theme.brown
        blackView.addSubview(bgView)
        
        newPriceLabel.numberOfLines = 0
        newPriceLabel.textAlignment = .center
        newPriceLabel.backgroundColor = UIColor.Theme.golden
        newPriceLabel.text = "98.0"
        newPriceLabel.textColor = UIColor.Theme.goldenBlack
        newPriceLabel.setFont(size: 16, isBold: true)
        newPriceLabel.setCornerRadius(25)
        bgView.addSubview(newPriceLabel)
        
        oldPriceLabel.attributedText = "188.0".xw_addDeleteline()
        oldPriceLabel.textColor = UIColor.white
        oldPriceLabel.setFont(size: 12)
        bgView.addSubview(oldPriceLabel)
        
        typeLabel.text = monthCard
        typeLabel.textColor = UIColor.white
        typeLabel.setFont(size: 16)
        bgView.addSubview(typeLabel)
        
        priceLabel.text = only + "3.3" + dayAndYuan
        priceLabel.textColor = UIColor.Theme.golden
        priceLabel.textAlignment = .center
        priceLabel.setFont(size: 14)
        bgView.addSubview(priceLabel)
        
        discountLabel.text = "66" + discount
        discountLabel.textAlignment = .center
        discountLabel.setBGImage(name: "arrow_bg")
        discountLabel.setCornerRadius(10)
        discountLabel.textColor = UIColor.white
        discountLabel.setFont(size: 14)
        bgView.addSubview(discountLabel)
        
        newUserLabel.text = specialOffer
        newUserLabel.textAlignment = .center
        newUserLabel.backgroundColor = UIColor.rgb(60, 56, 44)
        newUserLabel.textColor = UIColor.Theme.golden
        newUserLabel.setFont(size: 9)
        newUserLabel.setCornerRadius(5)
        bgView.addSubview(newUserLabel)
        
        confirmBtn.setText(text: toTopup)
        confirmBtn.setFont(size: 14)
        confirmBtn.setTextColor(color: UIColor.Theme.goldenBlack)
        confirmBtn.backgroundColor = UIColor.Theme.golden
        confirmBtn.setCornerRadius(12)
        bgView.addSubview(confirmBtn)
        
        blackView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        bgView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(80)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        newPriceLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        typeLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(bgView.snp.centerY)
            make.left.equalTo(newPriceLabel.snp.right).offset(10)
            make.width.greaterThanOrEqualTo(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        oldPriceLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(typeLabel)
            make.left.equalTo(typeLabel.snp.right).offset(10)
            make.width.greaterThanOrEqualTo(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(typeLabel.snp.bottom).offset(5)
            make.left.equalTo(typeLabel)
            make.width.greaterThanOrEqualTo(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        confirmBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalTo(newPriceLabel)
            make.width.equalTo(80)
            make.height.equalTo(24)
        }
        
        newUserLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(typeLabel)
            make.left.equalTo(typeLabel.snp.right).offset(10)
            make.width.equalTo(70)
            make.height.equalTo(10)
        }

        discountLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(20)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func updateData() {
        
        priceLabel.text = only + (model.unit ?? "0.0") + dayAndYuan
        newPriceLabel.text = model.amount! + "\n" + yuan
        oldPriceLabel.attributedText = model.price?.xw_addDeleteline()
        typeLabel.text = model.name
        discountLabel.text = "66" + discount
    }
    
}
