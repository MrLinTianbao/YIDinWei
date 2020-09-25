//
//  MineView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/6.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class MineView: XWView {
    
    var pushBlock : ((Int)->Void)?
    
    var setBlock : (()->Void)?
    
    var renewalBlock : (()->Void)?
    
    var signInBlock : (()->Void)?
    
    fileprivate let cellId = "mineCell"
    
    fileprivate let dataArray = [[myPath,contact],[share,useTutorial],[customerService,commonQuession]]
    
    fileprivate lazy var tableView : UITableView = {
        
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.backgroundColor = UIColor.Theme.bgColor
        let headView = MineHeadView.init(frame: .init(x: 0, y: 0, width: ScreenW, height: 240))
        headView.setbutton.addAction { (sender) in
            self.setBlock?()
        }
        headView.renewalBtn.addAction { (sender) in
            self.renewalBlock?()
        }
        headView.headImageView.addAction { (sender) in
            self.signInBlock?()
        }
        headView.nickNameLabel.addAction { (sender) in
            self.signInBlock?()
        }
        headView.phoneLabel.addAction { (sender) in
            self.signInBlock?()
        }
        tableView.tableHeaderView = headView
        tableView.tableFooterView = XWView()
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MineCell.self, forCellReuseIdentifier: cellId)
        return tableView
        
    }()

    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor.Theme.bgColor
        
        self.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MineView : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray[section].count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headView = XWView.init(frame: .init(x: 0, y: 0, width: ScreenW, height: 10))
        headView.backgroundColor = UIColor.Theme.bgColor
        return headView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? MineCell
        cell?.selectionStyle = .none
        cell?.titleLabel.text = dataArray[indexPath.section][indexPath.row]
        
        cell?.contentView.layoutIfNeeded()
        
        if indexPath.row == 0 {
            cell?.bgView.setCorner(cornerRadius: 10, corner: [.topLeft,.topRight])
        }else{
            cell?.bgView.setCorner(cornerRadius: 10, corner: [.bottomLeft,.bottomRight])
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 && indexPath.row == 0 {
            let shareView = FriendShareView.init(frame: window!.bounds)
            shareView.shareBlock = {(index) in
                CarePresenter.shareForWechat(type: Int32(index))
                shareView.removeFromSuperview()
            }
            window?.addSubview(shareView)

            shareView.showDateView()
        }else{
            self.pushBlock?(indexPath.section * 10 + indexPath.row)
        }
        
        

    }
    
}
