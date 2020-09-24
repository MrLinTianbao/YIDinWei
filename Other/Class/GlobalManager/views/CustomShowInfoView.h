//
//  YZGAlertView.h
//  Masonry
//
//  Created by LXY on 16/6/14.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomShowInfoView : UIView
@property (nonatomic,copy) void(^confirmBlock)(void);

+ (void)showCustomInfoViewWithText:(NSString *)text ConfirmBlock:(void(^)(void))confirmBlock;
+ (void)showCustomInfoViewWithText:(NSString *)text HeadImg:(NSString *)headImg CovImg:(NSString *)covImg ConfirmBlock:(void(^)(void))confirmBlock;

- (void)show;

@end
