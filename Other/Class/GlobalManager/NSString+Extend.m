//
//  NSString+Password.m
//  03.数据加密
//
//  Created by 刘凡 on 13-12-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "NSString+Extend.h"
#import "异定位-Swift.h"
@implementation NSString (Extend)


-(NSString *)localized{
    return [MJManager OCLocalizedWithText:self];
}






@end
