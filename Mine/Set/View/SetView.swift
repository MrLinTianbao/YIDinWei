//
//  SetView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/11.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class SetView: XWView {
    
    var signOutBlock : (()->Void)?
    
    var selectBlcok : ((Int)->Void)?
    
    fileprivate let cellId = "setCell"
    
    fileprivate let dataArray = [privacyPolicy,userProtocol,paymentProtocol]
    
    fileprivate lazy var tableView : UITableView = {
        
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.tableFooterView = XWView()
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SetCell.self, forCellReuseIdentifier: cellId)
        return tableView
        
    }()
    
    fileprivate lazy var signOutBtn : XWButton = {
       
        let button = XWButton()
        button.addAction { (sender) in
            self.signOutBlock?()
        }
        button.backgroundColor = UIColor.white
        button.setText(text: signOut)
        button.setFont(size: 16)
        button.setTextColor(color: UIColor.Theme.green)
        button.setCornerRadius(20)
        button.setShadow(offsetW: 0, offsetH: 0)
        return button
        
    }()

    init() {
        super.init(frame: .zero)
        
        self.addSubview(tableView)
        
        self.addSubview(signOutBtn)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
        signOutBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SetView : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SetCell
        cell?.selectionStyle = .none
        cell?.accessoryType = .disclosureIndicator
        cell?.titleLabel.text = dataArray[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.selectBlcok?(indexPath.row)

    }
    
}
