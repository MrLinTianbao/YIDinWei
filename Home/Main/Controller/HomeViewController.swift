//
//  HomeViewController.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/5.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class HomeViewController: XWViewController {
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        self.navigationController?.navigationBar.isHidden = true
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//
//        self.navigationController?.navigationBar.isHidden = false
//
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = careAbout
        
        setNavRightItem(imageStr: "lingdang")
        
        let homeView = HomeView()
        homeView.noticeBlock = {
            HomePresenter.setReadMsg()
            self.navigationController?.pushViewController(NoticeViewController())
        }
        homeView.pushBlock = {(index) in
            self.navigationController?.pushViewController(MyPathViewController.init(userId: homeView.dataArray[index].friendUserId ?? ""))
        }
        homeView.addBlock = {
            if !isLogin {
                self.navigationController?.pushViewController(SignInViewController())
            }else{
                self.navigationController?.pushViewController(CareViewController())
            }
        }
        homeView.helpBlock = {
            if !isLogin {
                self.navigationController?.pushViewController(SignInViewController())
            }else{
                self.navigationController?.pushViewController(AlarmViewController())
            }
        }
        self.view.addSubview(homeView)

        homeView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
    }
    
    override func actionRightItemClick() {
        
        HomePresenter.setReadMsg()
        self.navigationController?.pushViewController(NoticeViewController())
        
    }
    

}


