//
//  UnlockView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/11.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit
import SwiftyJSON

class UnlockView: XWView {
    
    var agreementBlock : ((String)->Void)?
    
    fileprivate let cellId = "unlockCell"
    
    fileprivate var selectIndex = 0
    
    fileprivate var count = 0 //请求次数
    
    fileprivate var dataArray = [UnlockModel]()
    var payList = [PayModel]()
    
    var backBlock : (()->Void)?
    
    fileprivate let titleLabel = XWLabel()
    fileprivate let backImage = XWButton()
    
    fileprivate let bgView = XWImageView()
    
    fileprivate lazy var tableView : UITableView = {
        
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor.Theme.bgColor
        let headView = UnlockHeadView.init(frame: .init(x: 0, y: 0, width: ScreenW, height:  160))
        let footView = UnlockFootView.init(frame: .init(x: 0, y: 0, width: ScreenW, height: 140))
        footView.agreementBlock = {(text) in
            self.agreementBlock?(text)
        }
        
        tableView.tableHeaderView = headView
        tableView.tableFooterView = footView
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UnlockCell.self, forCellReuseIdentifier: cellId)
        return tableView
        
    }()

    init() {
        super.init(frame: .zero)
        
        bgView.image = "unlock_bg".getImage()
        self.addSubview(bgView)
        
        titleLabel.text = unlockFunction
        titleLabel.setFont(size: 20,isBold: true)
        self.addSubview(titleLabel)
        
        backImage.setImage(image: "white_back",color: UIColor.black)
        backImage.addAction { (sender) in
            self.backBlock?()
        }
        self.addSubview(backImage)
        
        NotificationCenter.default.addObserver(self, selector: #selector(checkPayStatus), name: .checkPayStatus, object: nil)
        
        self.addSubview(tableView)
        
        bgView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(ScreenW*0.677)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(isIPhoneX ? 54 : 34)
            make.centerX.equalToSuperview()
            make.width.greaterThanOrEqualTo(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        backImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalTo(titleLabel)
            make.width.height.equalTo(30)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.left.right.bottom.equalToSuperview()
        }
        
        getData()
        
    }
    
    @objc fileprivate func checkPayStatus(sender:Notification) {
        
        let json = JSON.init(sender.userInfo!)
        
        if let orderId = json["orderId"].string {
            
            if self.count < 10 {
                self.count += 1
                UnlockPresenter.checkPayStatus(orderId: orderId)
            }
            
        }
        
        
        
    }
    
    fileprivate func getData() {
        
        UnlockPresenter.getPayList { (array,list) in
            
            self.dataArray = array
            self.payList = list
            self.tableView.reloadData()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UnlockView : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == dataArray.count - 1 {
            return 120
        }
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? UnlockCell
        cell?.selectionStyle = .none
        
        cell?.discountLabel.isHidden = indexPath.row < 2
        cell?.newUserLabel.isHidden = indexPath.row < 2
        cell?.oldPriceLabel.isHidden = indexPath.row >= 2
        cell?.model = dataArray[indexPath.row]
        
        cell?.isSelect = selectIndex == indexPath.row
        
        if indexPath.row == dataArray.count - 1 {
            cell?.contentView.layoutIfNeeded()
            cell?.blackView.setCorner(cornerRadius: 10, corner: [.bottomLeft,.bottomRight])
        }else{
            cell?.contentView.layoutIfNeeded()
            cell?.blackView.setCorner(cornerRadius: 0, corner: [.bottomLeft,.bottomRight])
        }
        
        cell?.confirmBtn.addAction({ (sender) in
            
            for model in self.payList {
                if model.mchType == "applePay" {
                    UnlockPresenter.purchasingRecharge(model: self.dataArray[indexPath.row], thirdPayId: model.id!)
                }
            }
        })
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.selectIndex = indexPath.row
        self.tableView.reloadData()
        

    }
    
    
    
}
