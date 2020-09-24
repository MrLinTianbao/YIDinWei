//
//  ContactView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/11.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class ContactView: XWView {
    
    fileprivate let cellId = "contactCell"
    
    fileprivate var dataArray = [ContactModel]()
    
    var addBlock : (()->Void)?
    var friListBlock : (()->Void)?
    
    var phoneNum = ""
    
    fileprivate lazy var addButton : XWButton = {
       
        let button = XWButton()
        button.backgroundColor = UIColor.white
        button.setText(text: addContact)
        button.setFont(size: 16)
        button.backgroundColor = UIColor.Theme.green
        button.setCornerRadius(20)
        button.setShadow(offsetW: 0, offsetH: 0)
        button.addAction { (sender) in
            self.showSelectView()
        }
        return button
        
    }()
    
    fileprivate lazy var tableView : UITableView = {
        
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.tableFooterView = XWView()
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactCell.self, forCellReuseIdentifier: cellId)
        return tableView
        
    }()

    init() {
        super.init(frame: .zero)
        
        self.addSubview(tableView)
        
        self.addSubview(addButton)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
        addButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
        
        AlertClass.setRefresh(with: tableView, headerAction: {[weak self] in
            self?.getData()
        }, footerAction: nil)
        
        self.tableView.mj_header?.beginRefreshing()
        
    }
    
    fileprivate func getData() {
        
        ContactPresenter.getContactList(parameters: ["style":"1"], success: { (array) in
            
            self.dataArray.removeAll()
            self.dataArray = array
            
            self.tableView.mj_header?.endRefreshing()
            
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
    
    public func showSelectView() {
        
        UIView.animate(withDuration: 0.2) {
            
            let addView = AddContactView.init(frame: self.bounds)
            
            addView.phoneNumer = self.phoneNum
            
            addView.addBlock = {
                
                if addView.phoneView.text == "" {
                    AlertClass.showToat(withStatus: inputPhone)
                    return
                }
                
                if addView.phoneView.text.count != 11 {
                    AlertClass.showToat(withStatus: phoneError)
                    return
                }
                
                AlertClass.waiting(isAdd)
                
                AlarmPresenter.addFriend(parameters: ["phone":addView.phoneView.text,"style":"1"]) {
                    self.getData()
                }
                self.phoneNum = ""
                addView.removeFromSuperview()
                
                
            }
            
            addView.bookBlock = {
                self.phoneNum = ""
                addView.removeFromSuperview()
                self.addBlock?()
            }
            addView.friListBlock = {
                self.phoneNum = ""
                addView.removeFromSuperview()
                self.friListBlock?()
            }
            
            UIApplication.shared.keyWindow?.addSubview(addView)
            
            addView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            
            addView.showSelectView()
        }
    }
    
    //MARK: 删除联系人
    fileprivate func deleteAction(index:Int) {
        
        AlertClass.show(isDelete)
        
        ContactPresenter.deleteContact(parameters: ["style":"1","userId":dataArray[index].friendUserId ?? ""]) {
            
            AlertClass.stop()
            self.getData()
            
        }
        
    }
}

extension ContactView : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ContactCell
        cell?.selectionStyle = .none
        cell?.model = dataArray[indexPath.row]
        
        cell?.deleteBtn.addAction({ (sender) in
            
            AlertClass.setAlertView(msg: deleteContact, target: self.window?.rootViewController, haveCancel: true) { (alert) in
                self.deleteAction(index: indexPath.row)
            }
            
            
        })
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        

    }
    
}
