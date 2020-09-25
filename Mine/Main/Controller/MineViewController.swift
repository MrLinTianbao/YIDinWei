//
//  MineViewController.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/5.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class MineViewController: XWViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        SignInPresenter.getUserNews()
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mineView = MineView()
        mineView.pushBlock = {(index) in
            
            self.pushAction(index: index)
        }
        mineView.setBlock = {
            if !isLogin {
                self.navigationController?.pushViewController(SignInViewController())
            }else{
                self.navigationController?.pushViewController(SetViewController())
            }
        }
        mineView.renewalBlock = {
            if !isLogin {
                self.navigationController?.pushViewController(SignInViewController())
            }else{
                self.navigationController?.pushViewController(UnlockViewController())
            }
            
        }
        mineView.signInBlock = {
            if !isLogin {
                self.navigationController?.pushViewController(SignInViewController())
            }
        }
        self.view.addSubview(mineView)
        
        mineView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
    }

    fileprivate func pushAction(index:Int) {
        
        if !isLogin {
            self.navigationController?.pushViewController(SignInViewController())
            return
        }
        
        switch index {
        case 0:
            self.navigationController?.pushViewController(MyPathViewController())
        case 1:
            self.navigationController?.pushViewController(ContactViewController())
        case 20:
            self.navigationController?.pushViewController(ServiceViewController())
        case 11:
            self.navigationController?.pushViewController(UseViewController())
        case 21:
            self.navigationController?.pushViewController(XWWebViewController())
        default:
            break
        }
        
    }

}
