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
    
    fileprivate let dataArray = [["image":"ic_me_path","title":myPath],["image":"ic_me_emergency","title":contact],["image":"ic_online_service","title":customerService],["image":"ic_me_share","title":share]/**,["image":"ic_me_loacation_setting","title":locationSet]**/,["image":"ic_me_tutorial","title":useTutorial],["image":"question","title":commonQuession]]
    
    fileprivate lazy var tableView : UITableView = {
        
        let tableView = UITableView.init(frame: .zero, style: .plain)
        let headView = MineHeadView.init(frame: .init(x: 0, y: 0, width: ScreenW, height: 220))
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? MineCell
        cell?.selectionStyle = .none
        cell?.accessoryType = .disclosureIndicator
        
        if indexPath.row == dataArray.count-1 {
            cell?.logoImageView.image = dataArray[indexPath.row]["image"]?.getImage().xw_imageChangeColor(UIColor.Theme.green)
        }else{
            cell?.logoImageView.image = dataArray[indexPath.row]["image"]?.getImage()
        }
        cell?.titleLabel.text = dataArray[indexPath.row]["title"]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 3 {
            let shareView = FriendShareView.init(frame: window!.bounds)
            shareView.shareBlock = {(index) in
                CarePresenter.shareForWechat(type: Int32(index))
                shareView.removeFromSuperview()
            }
            window?.addSubview(shareView)

            shareView.showDateView()
        }else{
           self.pushBlock?(indexPath.row)
        }
        
        

    }
    
}
