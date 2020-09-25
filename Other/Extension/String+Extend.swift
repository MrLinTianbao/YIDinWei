//
//  String+Extend.swift
//  YueXinWenHua
//
//  Created by TiBo's Mac on 2020/5/26.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import Foundation
import UIKit
import SwifterSwift

extension String {
    
    //MARK: 计算文本高度
    func xw_calculateHeigh(withWidth width:CGFloat,size:CGFloat,lineSpacing:CGFloat) -> CGFloat{
        
        let font = UIFont.systemFont(ofSize: size)
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineSpacing //行间距
        
        let attribute = [NSAttributedString.Key.font:font,NSAttributedString.Key.paragraphStyle:style]
        
        let value = NSString.init(string: self)
        
        let textSize = value.boundingRect(with: CGSize(width: width, height:CGFloat(MAXFLOAT)), options:  [.truncatesLastVisibleLine, .usesLineFragmentOrigin, .usesFontLeading], attributes: attribute, context: nil).size
        
        return textSize.height + 10
        
    }
    
    //MARK: 计算文本宽度
    func xw_calculateWidth(withHeight height:CGFloat,size:CGFloat) -> CGFloat{
        
        let font = UIFont.systemFont(ofSize: size)
        
        let attribute = [NSAttributedString.Key.font:font]
        let value = NSString.init(string: self)
        let rect = value.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options:  [.truncatesLastVisibleLine, .usesLineFragmentOrigin, .usesFontLeading] , attributes: attribute, context: nil)
        return rect.size.width + 10
    }
    
    // MARK: 设置字体的行距
    public func xw_changeLineForString(lineSpace:CGFloat) -> NSAttributedString{
        
        let attributedString = NSMutableAttributedString.init(string: self)
        let paragraphStye = NSMutableParagraphStyle()
        
        paragraphStye.lineSpacing = lineSpace
        let rang = NSMakeRange(0, CFStringGetLength(self as CFString))
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStye, range: rang)
        
        return attributedString
    }
    
    // MARK: 设置字体的间距
    public func xw_changeSpaceForString(lineSpace:CGFloat) -> NSAttributedString{
        
        let attributedString = NSMutableAttributedString.init(string: self, attributes: [NSAttributedString.Key.kern:lineSpace])
        let paragraphStye = NSMutableParagraphStyle()
        
        paragraphStye.lineSpacing = lineSpace
        let rang = NSMakeRange(0, CFStringGetLength(self as CFString))
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStye, range: rang)
        
        return attributedString
    }
    
    //MARK: 添加下划线
    public func xw_addUnderline() -> NSAttributedString {
        
        let text = NSMutableAttributedString(string: self)
        let range = NSRange(location: 0, length: text.length)
        text.addAttribute(.underlineStyle, value: NSUnderlineStyle.single, range: range)
        
        return text
        
    }
    
    //MARK: 添加删除线
    public func xw_addDeleteline() -> NSAttributedString {
        
        let attribtStr = NSAttributedString.init(string: self, attributes: [ NSAttributedString.Key.foregroundColor: UIColor.Theme.golden, NSAttributedString.Key.strikethroughStyle: NSNumber.init(value: Int8(NSUnderlineStyle.single.rawValue))])
        
        return attribtStr
        
    }
    
    //MARK: 字体样式
    public func setTextFont(isBold:Bool?=false,color:UIColor?=UIColor.black,fontSize:CGFloat,ranStr:String) -> NSAttributedString {
        
        var font : UIFont!
        
        //是否加粗
        if isBold! {
            font = UIFont.boldSystemFont(ofSize: fontSize)
        }else{
            font = UIFont.systemFont(ofSize: fontSize)
        }
        
        let str = NSMutableAttributedString.init(string: self)
        let range = (self as NSString).range(of: ranStr)
        str.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        str.addAttribute(NSAttributedString.Key.foregroundColor, value: color!, range: range)
        return str
    }
    
    func getImage() -> UIImage {
    
        return UIImage.init(named: self) ?? UIImage()
    }
    
    //MARK: 时间戳转时间
    public func getDate() -> String {
        
        let date = Date.init(timeIntervalSince1970: Double(self)!)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // HH:mm:ss
        let dateString = formatter.string(from: date)
        
        return dateString
    }
    
    //MARK: 时间转时间戳
    public func getTimestamp() -> Double {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        
        let last = formatter.date(from: self)
        let timeStamp = last?.timeIntervalSince1970
        
        return timeStamp ?? 0
    }

    func decodeFromPercentAndPlusString() -> String? {
        var outputStr = self
        if let subRange = Range<String.Index>(NSRange(location: 0, length: outputStr.count), in: outputStr) { outputStr = outputStr.replacingOccurrences(of: "+", with: " ", options: .literal, range: subRange) }
        return outputStr.removingPercentEncoding
    }
    
    func numberEncryption() -> String {
        
        if self.count < 7 {
            return self
        }
        
        let prefix = String(self.prefix(3))
        let suffix = String(self.suffix(4))
        
        return prefix + "****" + suffix
        
    }
    
}

extension String {
    
    /// 字符串转 URl (转码成UTf_8)
    ///
    /// - Returns:  url 地址
    var xw_url: URL{
        
        let trimPath = self.removingPercentEncoding
        if let url = URL.init(string: (trimPath?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!){
            return url
        }else{
            return URL.init(string: "wwww")!
        }
    }
    
    var xw_encodeString: String{
        
        let trimPath = self.removingPercentEncoding
        return  (trimPath?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!

       
    }
    
    /// 截取字符串
    ///
    /// - Returns: String
    func xw_stringBy(previousString:String,laterString:String) -> String? {
        let start = self.range(of: previousString)
        let end = self.range(of: laterString)
        
        let index = (start?.upperBound.encodedOffset)!
        let length = (end?.lowerBound.encodedOffset)! - index
        let subStr = self.slicing(from: index, length: length)
        
        return subStr
        
    }
    
    /*
     *去掉所有空格
     */
    var xw_removeAllSapce: String {
        return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    
    
}
