//
//  NoticeView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/17.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class NoticeView: XWView {

    fileprivate let cellId = "NoticeCell"
    
    fileprivate var dataArray = [NoticeModel]()
    
    fileprivate lazy var tableView : UITableView = {
        
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(NoticeCell.self, forCellReuseIdentifier: cellId)
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
        
        NoticePresenter.getNoticeList(success: { (array) in
            
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
    
    //MARK: 同意好友请求
    fileprivate func agreeAction(index:Int) {
        
        NoticePresenter.agreeFriendAction(parameters: ["id":dataArray[index].id ?? "","isAgree":"1"]) {
            
            NotificationCenter.default.post(name: .updateFriendList, object: nil)
            self.getData()
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension NoticeView : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let height = dataArray[indexPath.row].msg?.xw_calculateHeigh(withWidth: ScreenW-60, size: 16, lineSpacing: 0) ?? 0
        
        return height + 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? NoticeCell
        cell?.selectionStyle = .none
        cell?.model = dataArray[indexPath.row]
        
        if cell?.model.style == "1" && cell?.model.isAgree == "0" {
            cell?.agreeBtn.backgroundColor = UIColor.Theme.green
            cell?.agreeBtn.setText(text: agree)
            cell?.agreeBtn.setTextColor(color: UIColor.white)
            
            cell?.agreeBtn.addAction({ (sender) in
                self.agreeAction(index: indexPath.row)
            })
            
        }else{
            cell?.agreeBtn.backgroundColor = UIColor.clear
            cell?.agreeBtn.setText(text: hasAgree)
            cell?.agreeBtn.setTextColor(color: UIColor.Theme.font)
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    
}
