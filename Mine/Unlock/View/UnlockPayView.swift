//
//  UnlockPayView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/11.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class UnlockPayView: XWView {
    
    fileprivate let cellId = "unlockPayCell"
    
    var payBlock : ((PayModel)->Void)?
    
    fileprivate var payModel : PayModel!
    
    var dataArray = [PayModel]() {
        didSet{
            tableView.reloadData()
            
            tableView.snp.remakeConstraints { (make) in
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview().offset(-20)
                make.centerY.equalToSuperview()
                make.height.equalTo(140 + CGFloat(dataArray.count * 60))
            }
        }
    }
    
    lazy var tableView : UITableView = {
        
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.tableHeaderView = headView
        tableView.tableFooterView = footView
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UnlockPayCell.self, forCellReuseIdentifier: cellId)
        return tableView
        
    }()

    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor.Theme.alpha
        
        self.addSubview(tableView)
        
    }
    
    fileprivate lazy var headView : XWView = {
       
        let headView = XWView.init(frame: .init(x: 0, y: 0, width: ScreenW-40, height: 60))
        
        let titleLabel = XWLabel()
        titleLabel.text = selectPayType
        titleLabel.setFont(size: 16)
        headView.addSubview(titleLabel)
        
        let cancelBtn = XWButton()
        cancelBtn.setImage(image: "ic_close")
        cancelBtn.addAction { (sender) in
            self.removeFromSuperview()
        }
        headView.addSubview(cancelBtn)
        
        let lineView = XWView()
        lineView.backgroundColor = UIColor.Theme.lineColor
        headView.addSubview(lineView)
        
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.greaterThanOrEqualTo(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.width.height.equalTo(30)
            make.centerY.equalTo(titleLabel)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        return headView
        
    }()
    
    fileprivate lazy var footView : XWView = {
        
        let footView = XWView.init(frame: .init(x: 0, y: 0, width: ScreenW-40, height: 80))
        
        let lineView = XWView()
        lineView.backgroundColor = UIColor.Theme.lineColor
        footView.addSubview(lineView)
        
        let confirmBtn = XWButton()
        confirmBtn.setText(text: confirmPay)
        confirmBtn.backgroundColor = UIColor.Theme.red
        confirmBtn.setFont(size: 18)
        confirmBtn.setCornerRadius(5)
        confirmBtn.addAction { (sender) in
            
            if self.payModel == nil {
                AlertClass.showToat(withStatus: selectPayType)
                return
            }
            
            self.removeFromSuperview()
            self.payBlock?(self.payModel)
        }
        footView.addSubview(confirmBtn)
        
        lineView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        confirmBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(ScreenW/2)
        }
        
        return footView
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.removeFromSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension UnlockPayView : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? UnlockPayCell
        cell?.selectionStyle = .none
        cell?.model = dataArray[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as? UnlockPayCell
        cell?.isSelect = !cell!.isSelect
        
        if cell!.isSelect {
            self.payModel = dataArray[indexPath.row]
        }else{
            self.payModel = nil
        }
        

    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as? UnlockPayCell
        cell?.isSelect = false
        
    }
    
    
    
}
