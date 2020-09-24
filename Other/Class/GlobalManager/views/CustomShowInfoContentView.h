//
//  CustomShowInfoContentView.h
//  XLDoctor
//
//  Created by longma on 2018/8/7.
//  Copyright © 2018年 XLH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomShowInfoContentView : UIView
@property (nonatomic,copy) void(^cancelBlock)(void);
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (nonatomic,copy) void(^confirmBlock)(void);

@property (weak, nonatomic) IBOutlet UIImageView *imvVideo;
@property (weak, nonatomic) IBOutlet UIImageView *imvIcon;
@property (weak, nonatomic) IBOutlet UILabel *labName;



@end
