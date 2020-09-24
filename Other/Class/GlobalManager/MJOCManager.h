//
//  MJOCManager.h
//  JChat
//
//  Created by longma on 2019/7/26.
//  Copyright © 2019年 HXHG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MJOCManager : NSObject

+ (UIImage *)mj_firstFrameWithVideoURL:(NSURL *)url Size:(CGSize)size;
+ (UIImage*) mj_getVideoPreViewImage:(NSURL *)path;

///上传视频
+ (void)beginUpload;

/// 获取视频列表
+ (NSMutableArray *)getVideoArray;
@end

