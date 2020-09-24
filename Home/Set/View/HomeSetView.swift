//
//  HomeSetView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/5.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class HomeSetView: XWView {
    
    var pushBlock : ((Int)->Void)?
    
    fileprivate let cellId = "homeSetCell"
    
    fileprivate var dataArray = [selected,changeFriendNotes,removeBuddy,viewBuddyPath]
    
    lazy var tableView : UITableView = {
        
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.setCornerRadius(10)
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(HomeSetCell.self, forCellReuseIdentifier: cellId)
        return tableView
        
    }()


    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor.Theme.alpha
        self.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(ScreenW/3*2)
            make.height.equalTo(CGFloat(dataArray.count*50))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implem/Users/tibo/Desktop/XunWei/TabBarented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.removeFromSuperview()
        
    }
}

extension HomeSetView : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? HomeSetCell
        cell?.selectionStyle = .none
        cell?.titleLabel.text = dataArray[indexPath.row]
        
        if indexPath.row == 0 {
            cell?.titleLabel.setFont(size: 18,isBold: true)
            cell?.titleLabel.textColor = UIColor.black
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.removeFromSuperview()
        self.pushBlock?(indexPath.row)
        
    }
    
}
