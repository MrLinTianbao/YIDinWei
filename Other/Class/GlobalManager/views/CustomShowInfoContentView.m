//
//  CustomShowInfoContentView.m
//  XLDoctor
//
//  Created by longma on 2018/8/7.
//  Copyright © 2018年 XLH. All rights reserved.
//

#import "CustomShowInfoContentView.h"

@implementation CustomShowInfoContentView

- (void)awakeFromNib{
    [super awakeFromNib];
    
  [_imvVideo setContentMode:UIViewContentModeScaleAspectFill];
      _imvVideo.clipsToBounds=YES;
    [_imvIcon setContentMode:UIViewContentModeScaleAspectFill];
        _imvIcon.clipsToBounds=YES;
}
- (IBAction)actionCancel:(id)sender {
    if(self.cancelBlock)
        self.cancelBlock();
  
}
- (IBAction)actionConfirm:(id)sender {
    if(self.confirmBlock)
        self.confirmBlock();
}

@end
