//
//  YXNavigationController.swift
//  YueXinWenHua
//
//  Created by TiBo's Mac on 2020/5/26.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit
import RTRootNavigationController

class XWNavigationController: RTRootNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //若要修改导航栏相关属性须加这句代码
        self.useSystemBackBarButtonItem = true
        //适配iOS13全屏
        self.modalPresentationStyle = .fullScreen
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    

}
