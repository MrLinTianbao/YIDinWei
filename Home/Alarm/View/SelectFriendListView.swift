//
//  SelectFriendListView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/14.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class SelectFriendListView: XWView {
    
    fileprivate let cellId = "friendListCell"
    
    fileprivate var dataArray = [HomeModel]()
    
    var phoneBlock : ((String)->Void)?
    
    fileprivate lazy var tableView : UITableView = {
        
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(FriendListCell.self, forCellReuseIdentifier: cellId)
        return tableView
        
    }()

    init() {
        super.init(frame: .zero)
        
        self.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
        AlertClass.setRefresh(with: tableView, headerAction: {[weak self] in
            self?.getData()
        }, footerAction: nil)
        
        tableView.mj_header?.beginRefreshing()
        
    }
    
    fileprivate func getData() {
        
        HomePresenter.getUserPods(parameters: ["style":"0"], success: { (array) in
            self.tableView.mj_header?.endRefreshing()
            self.dataArray.removeAll()
            self.dataArray = array
            self.tableView.reloadData()
            
            self.showNotDataView(scrollView: self.tableView, count: self.dataArray.count)
            
        }) {
            self.tableView.mj_header?.endRefreshing()
            self.showErrorView(scrollView: self.tableView)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SelectFriendListView : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? FriendListCell
        cell?.selectionStyle = .none
        cell?.titleLabel.text = dataArray[indexPath.row].phone?.numberEncryption()
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.phoneBlock?(dataArray[indexPath.row].phone ?? "")
        
    }
    
}
