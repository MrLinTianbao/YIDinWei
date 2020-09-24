//
//  YZGAlertView.m
//  Masonry
//
//  Created by LXY on 16/6/14.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "CustomShowInfoView.h"
#import "CustomShowInfoContentView.h"
#import <SDWebImage.h>
// 屏幕宽度和高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define RGBA(r, g, b, a)    [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define kWindowColor RGBA(0, 0, 0, 0.5)//window 背景色

@interface CustomShowInfoView()<UIGestureRecognizerDelegate>


@property (nonatomic, strong) CustomShowInfoContentView *viewContent;

@property (nonatomic, strong) NSString *text;

@end

@implementation CustomShowInfoView
+ (void)showCustomInfoViewWithText:(NSString *)text HeadImg:(NSString *)headImg CovImg:(NSString *)covImg ConfirmBlock:(void(^)(void))confirmBlock{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
       CustomShowInfoView *blackView = [[CustomShowInfoView alloc] initWithFrame:keyWindow.frame];//黑色阴影
       [keyWindow addSubview:blackView];
       blackView.confirmBlock = confirmBlock;
    
    ///
      blackView.viewContent.labName.text = text;
     [blackView.viewContent.imvIcon sd_setImageWithURL:[NSURL URLWithString:headImg]];
    [blackView.viewContent.imvVideo sd_setImageWithURL:[NSURL URLWithString:covImg]];
    
    [blackView.viewContent.imvIcon sd_setImageWithURL:[NSURL URLWithString:headImg] placeholderImage:[UIImage imageNamed:@"logoX"]];
      
}
+ (void)showCustomInfoViewWithText:(NSString *)text ConfirmBlock:(void(^)(void))confirmBlock;
{

    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CustomShowInfoView *blackView = [[CustomShowInfoView alloc] initWithFrame:keyWindow.frame];//黑色阴影
    [keyWindow addSubview:blackView];
    blackView.viewContent.labTitle.text = text;
    blackView.confirmBlock = confirmBlock;
    
  
    
}
- (CustomShowInfoContentView *)viewContent {
    if (_viewContent == nil) {
        __weak typeof(self) weakSelf = self;
        _viewContent = (CustomShowInfoContentView *)[NSBundle.mainBundle loadNibNamed:@"CustomShowInfoContentView" owner:self options:nil].lastObject;
        _viewContent.alpha = 0;
        _viewContent.frame = CGRectMake(0, 0, SCREEN_WIDTH - 60, 244);
        _viewContent.center = self.center;
        _viewContent.layer.cornerRadius = 4;
        _viewContent.layer.masksToBounds = true;
        _viewContent.cancelBlock = ^{
            [weakSelf dismiss];
        };
        _viewContent.confirmBlock = ^{
            [weakSelf dismiss];
            if (weakSelf.confirmBlock)
                 weakSelf.confirmBlock();
        };
    }
    return _viewContent;
    
}
#pragma mark **************** init
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0];
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];//添加手势
        
        [self addSubview:self.viewContent];
        [self show];

    }
    return self;
}

#pragma mark ************** 显示
- (void)show {
    
    [UIView animateWithDuration:0.3f animations:^{
        [self setBackgroundColor:kWindowColor];
        self.viewContent.alpha = 1;

    } completion:nil];
}
#pragma mark ************** 消失
- (void)dismiss
{
    [UIView animateWithDuration:0.3f animations:^{
        self.backgroundColor = RGBA(0, 0, 0, 0);
        self.viewContent.alpha = 0;

    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}



#pragma mark ************** 父控件布局完成
- (void)layoutSubviews
{
    [super layoutSubviews];
}
#pragma mark ************** 子视图不响应父视图手势
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:self.viewContent]) {
        return NO;
    }
    
    return YES;
    
}

@end
