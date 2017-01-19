//
//  CrapPhotoViewController.h
//  StupidFM
//
//  Created by 寒竹子 on 15/6/18.
//  Copyright (c) 2015年 寒竹子. All rights reserved.
//

//#import "ParentViewController.h"
#import <UIKit/UIKit.h>
@class CrapPhotoViewController;

@protocol CrapPhotoViewControllerDelegate <NSObject>

@optional
// 点击确定完成图片裁剪的代理方法
- (void)imageCrap:(CrapPhotoViewController *)crapViewController didFinished:(UIImage *)editedImage;
// 点击取消后的代理方法
- (void)imageCrapDidCancel:(CrapPhotoViewController *)crapViewController;

@end

@interface CrapPhotoViewController : UIViewController

@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, weak)   id<CrapPhotoViewControllerDelegate> delegate;
@property (nonatomic, assign)  CGRect cropFrame;

// 初始化方法
- (instancetype)initWithImage:(UIImage *)orignalImage
                    cropFrame:(CGRect)cropFrame
              limitScaleRatio:(NSInteger)limitRatio;

@end
