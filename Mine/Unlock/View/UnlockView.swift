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
    
    fileprivate let cellId = "unlockCell"
    
    fileprivate var selectIndex = 0
    
    fileprivate var count = 0 //请求次数
    
    fileprivate var dataArray = [UnlockModel]()
    var payList = [PayModel]()
    
    var backBlock : (()->Void)?
    
    fileprivate lazy var tableView : UITableView = {
        
        let tableView = UITableView.init(frame: .zero, style: .plain)
        let headView = UnlockHeadView.init(frame: .init(x: 0, y: 0, width: ScreenW, height:  200))
        headView.backBlock = {
            self.backBlock?()
        }
        let footView = UnlockFootView.init(frame: .init(x: 0, y: 0, width: ScreenW, height: 200))
        footView.unlockBlock = {
            
            if !footView.isSelect {
                AlertClass.showToat(withStatus: agreeAgreement)
                return
            }
            
            for model in self.payList {
                if model.mchType == "applePay" {
                    UnlockPresenter.purchasingRecharge(model: self.dataArray[self.selectIndex], thirdPayId: model.id!)
                }
            }
            
            
            
//            let payView = UnlockPayView()
//            payView.dataArray = self.payList
//            payView.payBlock = {(model) in
//
//                switch model.mchType {
//                case "wxAppPay":
//
//                    self.count = 0
//
//                    UnlockPresenter.wechatPayAction(model: self.dataArray[self.selectIndex], thirdPayId: model.id!, success: {(orderId) in
//
//                        UnlockPresenter.checkPayStatus(orderId: orderId)
//
//                    })
//                case "applePay":
//                    UnlockPresenter.purchasingRecharge(model: self.dataArray[self.selectIndex], thirdPayId: model.id!)
//                default:
//                    break
//                }
//
//
//                payView.removeFromSuperview()
//            }
//            self.window?.addSubview(payView)
//
//            payView.snp.makeConstraints { (make) in
//                make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
//            }
//
//            payView.tableView.animationWithAlertViewWithView()
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(checkPayStatus), name: .checkPayStatus, object: nil)
        
        self.backgroundColor = UIColor.Theme.black
        
        self.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
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
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? UnlockCell
        cell?.selectionStyle = .none
        
        cell?.discountLabel.isHidden = indexPath.row < 2
        cell?.newUserLabel.isHidden = indexPath.row < 2
        cell?.model = dataArray[indexPath.row]
        
        if selectIndex == indexPath.row {
            cell?.selectView.isHidden = false
            cell?.oldPriceLabel.textColor = UIColor.Theme.golden
            cell?.newPriceLabel.textColor = UIColor.Theme.golden
        }else{
            cell?.selectView.isHidden = true
            cell?.oldPriceLabel.textColor = UIColor.white
            cell?.newPriceLabel.textColor = UIColor.white
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.selectIndex = indexPath.row
        self.tableView.reloadData()
        

    }
    
    
    
}
