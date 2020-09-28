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
    let discountLabel = XWButton()
    let newUserLabel = XWLabel()
    let confirmBtn = XWButton()
    
    let blackView = XWView()
    let bgView = XWView()
    
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
                bgView.setBGImage(name: "goldFill_bg")
                priceLabel.textColor = UIColor.Theme.goldenBlack
                oldPriceLabel.textColor = UIColor.Theme.goldenBlack
                oldPriceLabel.attributedText = oldPriceLabel.text?.xw_addDeleteline(color: UIColor.Theme.goldenBlack)
                confirmBtn.setTextColor(color: UIColor.Theme.golden)
                confirmBtn.backgroundColor = UIColor.Theme.goldenBlack
            }else{
                typeLabel.textColor = UIColor.Theme.golden
                newPriceLabel.backgroundColor = UIColor.Theme.golden
                newPriceLabel.textColor = UIColor.Theme.goldenBlack
                bgView.setBGImage(name: "gold_bg")
                priceLabel.textColor = UIColor.Theme.golden
                oldPriceLabel.attributedText = oldPriceLabel.text?.xw_addDeleteline(color: UIColor.Theme.golden)
                confirmBtn.setTextColor(color: UIColor.Theme.goldenBlack)
                confirmBtn.backgroundColor = UIColor.Theme.golden
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        blackView.backgroundColor = UIColor.Theme.vip_bg
        self.contentView.addSubview(blackView)
        
        bgView.backgroundColor = UIColor.clear
        blackView.addSubview(bgView)
        
        newPriceLabel.numberOfLines = 0
        newPriceLabel.textAlignment = .center
        newPriceLabel.backgroundColor = UIColor.Theme.golden
        newPriceLabel.text = "98.0"
        newPriceLabel.textColor = UIColor.Theme.goldenBlack
        newPriceLabel.setFont(size: 16, isBold: true)
        newPriceLabel.setCornerRadius(25)
        bgView.addSubview(newPriceLabel)
        
        oldPriceLabel.attributedText = "188.0".xw_addDeleteline(color: UIColor.Theme.golden)
        oldPriceLabel.textColor = UIColor.Theme.golden
        oldPriceLabel.setFont(size: 12)
        bgView.addSubview(oldPriceLabel)
        
        typeLabel.text = monthCard
        typeLabel.textColor = UIColor.Theme.goldenBlack
        typeLabel.setFont(size: 16,isBold: true)
        bgView.addSubview(typeLabel)
        
        priceLabel.text = only + "3.3" + dayAndYuan
        priceLabel.textColor = UIColor.Theme.golden
        priceLabel.textAlignment = .center
        priceLabel.setFont(size: 12)
        bgView.addSubview(priceLabel)
        
        discountLabel.setText(text: "66" + discount)
        discountLabel.setBGImage(name: "arrow_bg")
        discountLabel.setFont(size: 14)
        bgView.addSubview(discountLabel)
        
        newUserLabel.text = specialOffer
        newUserLabel.textAlignment = .center
        newUserLabel.backgroundColor = UIColor.rgb(60, 56, 44)
        newUserLabel.textColor = UIColor.Theme.golden
        newUserLabel.setFont(size: 9)
        newUserLabel.setCornerRadius(7)
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
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(newPriceLabel)
            make.width.equalTo(74)
            make.height.equalTo(24)
        }
        
        newUserLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(typeLabel)
            make.left.equalTo(typeLabel.snp.right).offset(10)
            make.width.equalTo(70)
            make.height.equalTo(14)
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
        oldPriceLabel.attributedText = model.price?.xw_addDeleteline(color: UIColor.Theme.golden)
        typeLabel.text = model.name
        discountLabel.setText(text: "66" + discount)
    }
    
}
