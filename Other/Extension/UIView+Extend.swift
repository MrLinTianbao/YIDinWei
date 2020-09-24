//
//  UIView+Extend.swift
//  YueXinWenHua
//
//  Created by TiBo's Mac on 2020/5/26.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /// 设置view的圆角
    ///
    /// - Parameter radius: 圆角半径
    func setCornerRadius(_ radius: CGFloat){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
    
    //设置边框
    func setborder(size: CGFloat?=1,color:UIColor?=UIColor.Theme.lineColor){
        self.layer.borderColor = color?.cgColor
        self.layer.borderWidth = size!
    }
    
    
    //MARK: 设置阴影
    func setShadow( offsetW:CGFloat,  offsetH:CGFloat,shadowColor:UIColor = UIColor.black) {
        self.layer.shadowOffset = CGSize.init(width: offsetW, height: offsetH)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowColor = shadowColor.cgColor
        self.clipsToBounds = false
    }
    
    /// 给控件本身添加圆角
    ///
    /// - Parameters:
    ///   - corner: 添加哪些圆角
    ///   - cornerRadius: 圆角半径
    ///   - targetSize: 目标大小，即控件的frame.size
    func setCorner(_ corner: UIRectCorner, cornerRadius: CGFloat, size targetSize: CGSize) {
        let frame = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height)
        let path = UIBezierPath(roundedRect: frame, byRoundingCorners: corner, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let layer = CAShapeLayer()
        layer.frame = frame
        layer.path = path.cgPath
        
        self.layer.mask = layer
    }
    
    /// 给控件本身添加圆角
    ///
    /// - Parameters:
    ///   - cornerRadius: 圆角半径
    ///   - corner: 添加哪些圆角
    func setCorner(cornerRadius: CGFloat, corner: UIRectCorner = .allCorners) {
        
        setCorner(corner, cornerRadius: cornerRadius, size: bounds.size)
    }
    
    //MARK: 添加4个不同大小的圆角
    func addCorner(cornerRadii:CornerRadii){
       let path = createPathWithRoundedRect(bounds: self.bounds, cornerRadii:cornerRadii)
       let shapLayer = CAShapeLayer()
       shapLayer.frame = self.bounds
       shapLayer.path = path
       self.layer.mask = shapLayer
    }
    
    //MARK: 各圆角大小
    struct CornerRadii {
        var topLeft :CGFloat = 0
        var topRight :CGFloat = 0
        var bottomLeft :CGFloat = 0
        var bottomRight :CGFloat = 0
    }
    
    //MARK: 切圆角函数绘制线条
    fileprivate func createPathWithRoundedRect( bounds:CGRect,cornerRadii:CornerRadii) -> CGPath
    {
        let minX = bounds.minX
        let minY = bounds.minY
        let maxX = bounds.maxX
        let maxY = bounds.maxY
        
        //获取四个圆心
        let topLeftCenterX = minX +  cornerRadii.topLeft
        let topLeftCenterY = minY + cornerRadii.topLeft
         
        let topRightCenterX = maxX - cornerRadii.topRight
        let topRightCenterY = minY + cornerRadii.topRight
        
        let bottomLeftCenterX = minX +  cornerRadii.bottomLeft
        let bottomLeftCenterY = maxY - cornerRadii.bottomLeft
         
        let bottomRightCenterX = maxX -  cornerRadii.bottomRight
        let bottomRightCenterY = maxY - cornerRadii.bottomRight
        
        //虽然顺时针参数是YES，在iOS中的UIView中，这里实际是逆时针
        let path :CGMutablePath = CGMutablePath();
         //顶 左
        path.addArc(center: CGPoint(x: topLeftCenterX, y: topLeftCenterY), radius: cornerRadii.topLeft, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 3 / 2, clockwise: false)
        //顶右
        path.addArc(center: CGPoint(x: topRightCenterX, y: topRightCenterY), radius: cornerRadii.topRight, startAngle: CGFloat.pi * 3 / 2, endAngle: 0, clockwise: false)
        //底右
        path.addArc(center: CGPoint(x: bottomRightCenterX, y: bottomRightCenterY), radius: cornerRadii.bottomRight, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: false)
        //底左
        path.addArc(center: CGPoint(x: bottomLeftCenterX, y: bottomLeftCenterY), radius: cornerRadii.bottomLeft, startAngle: CGFloat.pi / 2, endAngle: CGFloat.pi, clockwise: false)
        path.closeSubpath();
        
        return path;
    }
    
    //MARK: 设置背景图片
    func setBGImage(name:String,color:UIColor?=nil) {
        
        if color == nil {
            self.layer.contents = UIImage.init(named: name)?.cgImage
        }else{
            self.layer.contents = UIImage.init(named: name)?.xw_imageChangeColor(color!)?.cgImage
        }
        
        
    }
    
    //MARK: 弹框动画
    func animationWithAlertViewWithView() {
        
        var animation: CAKeyframeAnimation?
        animation = CAKeyframeAnimation(keyPath: "transform")
        animation?.duration = 0.2
        animation?.isRemovedOnCompletion = true
        animation?.fillMode = .forwards
        var values: [AnyHashable] = []
        values.append(NSValue(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)))
        values.append(NSValue(caTransform3D: CATransform3DMakeScale(1.1, 1.1, 1.0)))
        values.append(NSValue(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)))
        animation?.values = values
        self.layer.add(animation!, forKey: nil)
        
        
    }
    
}

extension UIView {
    
    //MARK: 显示错误信息页面
    public func showErrorView(scrollView:UIScrollView) {
        
        self.showNotDataView(scrollView: scrollView, count: 1)
        
        let imageView = ErrorView()
        imageView.frame = scrollView.bounds
        imageView.tag = 999
        scrollView.addSubview(imageView)
    }
    
    //MARK: 移除错误信息页面
    fileprivate func removeErrorView(scrollView:UIScrollView) {
        
        for tmpView in scrollView.subviews {
            
            if let imageView = tmpView as? ErrorView,imageView.tag == 999 {
                tmpView.removeFromSuperview()
            }
        }
        
    }
    
    //MARK: 显示空白页
    public func showNotDataView(scrollView:UIScrollView,count:Int) {
        
        self.removeErrorView(scrollView: scrollView)
        
        
        if count == 0 {
            
            let notDataView = NotDataView()
            notDataView.frame = scrollView.bounds
            notDataView.tag = 999
            scrollView.addSubview(notDataView)
            
        }else{
            
            for tmpView in scrollView.subviews {
                
                if let notDataView = tmpView as? NotDataView,notDataView.tag == 999 {
                    notDataView.removeFromSuperview()
                }
            }
            
        }
        
    }
    
}

//MARK: ********************************************************  frame
 extension UIView {
    
    //获取视图的X坐标
    public var x:CGFloat{
        get{
            return self.frame.origin.x;
        }
        
        set{
            var frames = self.frame;
            frames.origin.x = CGFloat(newValue);
            self.frame = frames;
        }
    }
    
    //获取视图的Y坐标
    public var y:CGFloat{
        get{
            return self.frame.origin.y;
        }
        
        set{
            var frames = self.frame;
            frames.origin.y = CGFloat(newValue);
            self.frame = frames;
        }
    }
    
    //获取视图的宽
    public var width:CGFloat{
        get{
            return self.frame.size.width;
        }
        
        set{
            var frames = self.frame;
            frames.size.width = CGFloat(newValue);
            self.frame = frames;
        }
    }
    
    //获取视图的高
    public var height:CGFloat{
        get{
            return self.frame.size.height;
        }
        
        set{
            var frames = self.frame;
            frames.size.height = CGFloat(newValue);
            self.frame = frames;
        }
    }
    
    // top
    var top:CGFloat {
        get {
            return frame.minY
        }
        set(newValue) {
            var tempFrame:CGRect = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
        }
    }
    
    // bottom
    var bottom:CGFloat {
        get {
            return frame.maxY
        }
        set(newValue) {
            var tempFrame:CGRect = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
        }
    }
    
    // left
    var left:CGFloat {
        get {
            return frame.minX
        }
        set(newValue) {
            var tempFrame:CGRect = frame
            tempFrame.origin.x = newValue
            frame = tempFrame
        }
    }
    
    // right
    var right:CGFloat {
        get {
            return frame.maxX
        }
        set(newValue) {
            var tempFrame:CGRect = frame
            tempFrame.origin.x = newValue
            frame = tempFrame
        }
    }
    
  
    
    
    //获取最大的X坐标
    public var maxX:CGFloat{
        get{
            return self.x + self.width;
        }
        
        set{
            var frames = self.frame;
            frames.origin.x = CGFloat(newValue - self.width);
            self.frame = frames;
        }
    }
    
    //获取最大的Y坐标
    public var maxY:CGFloat{
        get{
            return self.y + self.height;
        }
        
        set{
            var frames = self.frame;
            frames.origin.y = CGFloat(newValue - self.height);
            self.frame = frames;
        }
    }
    
    //中心点X坐标
    public var centerX:CGFloat{
        get{
            return self.center.x;
        }
        set{
            self.center = CGPoint(x:CGFloat(newValue),y:self.center.y);
        }
    }
    
    //中心点Y坐标
    public var centerY:CGFloat{
        get{
            return self.center.y;
        }
        set{
            self.center = CGPoint(x:self.center.x,y:CGFloat(newValue));
        }
    }
    
    
}

