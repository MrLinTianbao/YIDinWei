//
//  XWTabBarController.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/7/28.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class XWTabBarController: UITabBarController {
    
    fileprivate let locationTabBar = LocationTabBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 10.0, *) {
            UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        } else {
            
        } //设置为选中颜色
        
        setCenterButton()


        self.addChildrenViewController(childVC: HomeViewController(), title: careAbout, imageName: "main_guanxin_n", selectImage: "main_guanxin_s")
        self.addChildrenViewController(childVC: LocationViewController(), title: "", imageName: "", selectImage: "")
        self.addChildrenViewController(childVC: MineViewController(), title: mine, imageName: "main_mine_n", selectImage: "main_mine_s")
        
    }
    
    //MARK: 设置中间按钮
    fileprivate func setCenterButton() {
        
        locationTabBar.centerBtn.addAction { (sender) in
            
            self.selectedIndex = 1
            
        }
        
        locationTabBar.isTranslucent = false
        
        //利用KVC 将自己的tabbar赋给系统tabBar
        self.setValue(locationTabBar, forKey: "tabBar")
        self.selectedIndex = 0
        self.delegate = self
        
    }
    
    
    //MARK: 添加子视图
    fileprivate func addChildrenViewController(childVC:UIViewController,title:String,imageName:String,selectImage:String) {
        
        let tabBar = UITabBarItem.init(title: title, image: imageName.getImage().withRenderingMode(.alwaysOriginal), selectedImage: selectImage.getImage().withRenderingMode(.alwaysOriginal))

        tabBar.setTitleTextAttributes(convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor) : UIColor.black]), for: .selected)
        

        let nav = XWNavigationController(rootViewController: childVC)
        nav.tabBarItem = tabBar
        
        self.addChild(nav)
        
    }
    
    
    // Helper function inserted by Swift 4.2 migrator.
       fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
           guard let input = input else { return nil }
           return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
       }
       
       // Helper function inserted by Swift 4.2 migrator.
       fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
           return input.rawValue
       }
    

    

}

extension UITabBarController : UITabBarControllerDelegate {
    
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        
        
    }
    
}
