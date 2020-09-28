//
//  UseViewController.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/12.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit
import SGPagingView

class UseViewController: XWViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = useTutorial
        
        let headView = UseHeadView()
        headView.shareBlock = {
            CarePresenter.shareForWechat(type: 0)
        }
        self.view.addSubview(headView)
        
        headView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(60)
        }
        
        self.view.addSubview(pageTitleView)
        self.view.addSubview(pageContentScrollView)
        
    }
    
    
   //MARK: 滚动视图
   fileprivate lazy var pageContentScrollView: SGPageContentScrollView = {
       
       let vc1 = CareAboutViewController()
       let vc2 = FirendPathViewController()

       let childVCs = [vc1,vc2]
       let view = SGPageContentScrollView.init(frame: CGRect.init(x: 0, y: 100, width: ScreenW , height: ScreenH - 100 - StatusBarAddNavBarHeight), parentVC: self, childVCs: childVCs)
       view?.isAnimated = true
       view?.delegatePageContentScrollView = self
       return view!
   }()
   
   //MARK: 滚动标签
   fileprivate lazy var pageTitleView: SGPageTitleView = {
       
    let view = SGPageTitleView.init(frame: CGRect.init(x: 0, y: 60, width: ScreenW, height: 40), delegate: self, titleNames: [careAbout,friendPath], configure: self.configPageView(titleSelectedColor: UIColor.Theme.red))!
       view.backgroundColor = UIColor.white
       
       return view
   }()
   
   /// 配置分页控制
       ///
       /// - Returns: 样色
        fileprivate func configPageView(titleSelectedColor:UIColor = UIColor.black) -> SGPageTitleViewConfigure{
           let configure = SGPageTitleViewConfigure.init()
   //        configure.bounces = false
           configure.titleFont = UIFont.systemFont(ofSize: 16)
           configure.titleColor = UIColor.Theme.font
           configure.titleSelectedColor = titleSelectedColor
           configure.indicatorStyle = SGIndicatorStyleFixed
           configure.bottomSeparatorColor = UIColor.clear
           configure.indicatorColor = UIColor.Theme.red
           configure.indicatorAnimationTime = 0.2
           configure.indicatorFixedWidth = ScreenW/2
           configure.indicatorHeight = 2
//           configure.indicatorCornerRadius = 2
           
           return configure
       }

}

extension UseViewController: SGPageContentScrollViewDelegate,SGPageTitleViewDelegate  {
    func pageTitleView(_ pageTitleView: SGPageTitleView!, selectedIndex: Int) {
        self.pageContentScrollView.setPageContentScrollViewCurrentIndex(selectedIndex)
    }
    func pageContentScrollView(_ pageContentScrollView: SGPageContentScrollView!, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        self.pageTitleView.setPageTitleViewWithProgress(progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
    
}
