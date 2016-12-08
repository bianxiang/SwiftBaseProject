//
//  OCTool.h
//  FindWork
//
//  Created by bianxiang on 2016/11/9.
//  Copyright © 2016年 bianxiang. All rights reserved.
//


#import <UIKit/UIKit.h>
@interface OCTool : NSObject
//获取视频某一桢图片
+ (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;

//拍照如果该图片大于2M，会自动旋转90度；否则不旋转
+ (UIImage *)fixOrientation:(UIImage *)aImage;
/**
 *  DES加密数据
 *
 *  @param plainText plainText description
 *  @param key       key description
 *
 *  @return return value description
 */
+ (NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key;


+ (NSString*)remainingTimeMethodAction:(long long)endTime completeBlock:(void (^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second))completeBlock;
@end
