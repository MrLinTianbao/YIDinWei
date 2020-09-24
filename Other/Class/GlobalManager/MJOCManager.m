//
//  MJOCManager.m
//  JChat
//
//  Created by longma on 2019/7/26.
//  Copyright © 2019年 HXHG. All rights reserved.
//

#import "MJOCManager.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVTime.h>
#import <Photos/Photos.h>
@implementation MJOCManager


+ (void)beginUpload {
    
}

#pragma mark ---- 获取图片第一帧
+ (UIImage *)mj_firstFrameWithVideoURL:(NSURL *)url Size:(CGSize)size
{
    // 获取视频第一帧
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    generator.appliesPreferredTrackTransform = YES;
    generator.maximumSize = CGSizeMake(size.width, size.height);
    NSError *error = nil;
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 10) actualTime:NULL error:&error];
    {
        return [UIImage imageWithCGImage:img];
    }
    return nil;
}

// 获取视频第一帧
+ (UIImage*) mj_getVideoPreViewImage:(NSURL *)path
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
    
    
}

+ (NSMutableArray *)getVideoArray{
    PHFetchResult *result = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeVideo options:nil];
    NSMutableArray *arr = [NSMutableArray array];
//    NSMutableArray *sourceArray = [NSMutableArray arrayWithCapacity:result.count];
    for (PHAsset *assets in result) {
//        NSArray *assetResources = [PHAssetResource assetResourcesForAsset:assets];
//        PHAssetResource *assetRes = [assetResources firstObject];
//        NSLog(@"originalFilename ===%@", assetRes.originalFilename);
//        NSLog(@"uniformTypeIdentifier ===%@", assetRes.uniformTypeIdentifier);
//        NSLog(@"assetLocalIdentifier ===%@", assetRes.assetLocalIdentifier);
        [arr insertObject:assets atIndex:0];
    }
    return arr;
    
//    PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
//    options.version = PHImageRequestOptionsVersionCurrent;
//    options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
//    [[PHImageManager defaultManager]requestAVAssetForVideo:videoAsset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
//         // 获取信息 asset audioMix info
//         // 上传视频时用到data
//         AVURLAsset *urlAsset = (AVURLAsset *)asset;
//         NSData *data = [NSData dataWithContentsOfURL:url];
//    }];
}
@end
