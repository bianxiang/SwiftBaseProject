//
//  CrapPhotoViewController.m
//  StupidFM
//
//  Created by 寒竹子 on 15/6/18.
//  Copyright (c) 2015年 寒竹子. All rights reserved.
//

#import "CrapPhotoViewController.h"

#define Scale_Y          100.0f
#define Boundce_Duration .3f

@interface CrapPhotoViewController ()

@property (nonatomic, strong) UIImage * orignalImage;
@property (nonatomic, strong) UIImage * editedImage;
@property (nonatomic, strong) UIImageView * showImageView;
@property (nonatomic, strong) UIView * overlayView;
@property (nonatomic, strong) UIView * ratioView;

@property (nonatomic, assign) CGRect oldFrame;
@property (nonatomic, assign) CGRect largeFrame;
@property (nonatomic, assign) CGFloat limitRatio;

@property (nonatomic, assign) CGRect lastFrame;

@end

@implementation CrapPhotoViewController

- (instancetype)initWithImage:(UIImage *)orignalImage cropFrame:(CGRect)cropFrame limitScaleRatio:(NSInteger)limitRatio
{
    if (self = [super init]) {
        self.cropFrame    = cropFrame;
        self.limitRatio   = limitRatio;
        self.orignalImage = orignalImage;
    }
    
    return self;
}

/**
 * @brief  初始化View
 *
 * @param
 *
 * @return
 */
- (void)initialView
{
//    self.view.backgroundColor = [UIColor blackColor];
    self.showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.showImageView setMultipleTouchEnabled:YES];
    [self.showImageView setUserInteractionEnabled:YES];
    self.showImageView.backgroundColor = [UIColor clearColor];
    [self.showImageView setImage:self.orignalImage];
    
    // 缩放适应屏幕
    CGFloat oriWidth = self.cropFrame.size.width;
    CGFloat oriHeight = self.orignalImage.size.height * (oriWidth / self.orignalImage.size.width);
    CGFloat oriX = self.cropFrame.origin.x + (self.cropFrame.size.width - oriWidth) / 2.0f;
    CGFloat oriY = self.cropFrame.origin.y + (self.cropFrame.size.height - oriHeight) / 2.0f;
    self.oldFrame = CGRectMake(oriX, oriY, oriWidth, oriHeight);
    self.lastFrame = self.oldFrame;
    self.showImageView.frame = self.oldFrame;
    self.largeFrame = CGRectMake(0, 0, self.limitRatio * self.oldFrame.size.width, self.limitRatio * self.oldFrame.size.height);
 
    [self addGestureRecognizers];
    [self.view addSubview:self.showImageView];
    
    self.overlayView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.overlayView.alpha = .6f;
    self.overlayView.backgroundColor = [UIColor blackColor];
    self.overlayView.userInteractionEnabled = NO;
    self.overlayView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.overlayView];
    
    self.ratioView = [[UIView alloc] initWithFrame:self.cropFrame];
    self.ratioView.layer.borderColor = [UIColor redColor].CGColor;
    self.ratioView.layer.borderWidth = 2.0f;
    self.ratioView.autoresizingMask = UIViewAutoresizingNone;
    [self.view addSubview:self.ratioView];
    
    [self overlayClipping];
}

- (void)initControlBtn {
    
    // 添加黑色的View
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 70.0f, self.view.frame.size.width, 70.0f)];
    backView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:backView];
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, backView.frame.size.height)];
    cancelBtn.backgroundColor = [UIColor clearColor];
    cancelBtn.titleLabel.textColor = [UIColor whiteColor];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:[UIFont fontWithName:@"Arial Unicode MS" size:17.0f]];
    [cancelBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [cancelBtn.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [cancelBtn setTitleEdgeInsets:UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f)];
    [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:cancelBtn];
    
    // 选取
    UIButton *confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100.0f, 0, 100, backView.frame.size.height)];
    confirmBtn.backgroundColor = [UIColor clearColor];
    confirmBtn.titleLabel.textColor = [UIColor whiteColor];
    [confirmBtn setTitle:@"选取" forState:UIControlStateNormal];
    [confirmBtn.titleLabel setFont:[UIFont fontWithName:@"Arial Unicode MS" size:17.0f]];
    [confirmBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    confirmBtn.titleLabel.textColor = [UIColor whiteColor];
    [confirmBtn.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [confirmBtn.titleLabel setNumberOfLines:0];
    [confirmBtn setTitleEdgeInsets:UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f)];
    [confirmBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:confirmBtn];
}

// 取消
- (void)cancelAction:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(imageCrapDidCancel:)]) {
        [self.delegate imageCrapDidCancel:self];
    }
}

// 确定
- (void)sureAction:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(imageCrap:didFinished:)]) {
        [self.delegate imageCrap:self didFinished:[self getSubImage]];
    }
}

/**
 * @brief  图片裁剪
 *
 * @param
 *
 * @return
 */
- (void)overlayClipping
{
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    // 画左边的line
    CGPathAddRect(path, nil, CGRectMake(0, 0,
                                        self.ratioView.frame.origin.x,
                                        self.overlayView.frame.size.height));
    // 画右边的line
    CGPathAddRect(path, nil, CGRectMake(
                                        self.ratioView.frame.origin.x + self.ratioView.frame.size.width,
                                        0,
                                        self.overlayView.frame.size.width - self.ratioView.frame.origin.x - self.ratioView.frame.size.width,
                                        self.overlayView.frame.size.height));
    // 画上边的line
    CGPathAddRect(path, nil, CGRectMake(0, 0,
                                        self.overlayView.frame.size.width,
                                        self.ratioView.frame.origin.y));
    // 画下边的line
    CGPathAddRect(path, nil, CGRectMake(0,
                                        self.ratioView.frame.origin.y + self.ratioView.frame.size.height,
                                        self.overlayView.frame.size.width,
                                        self.overlayView.frame.size.height - self.ratioView.frame.origin.y + self.ratioView.frame.size.height));
    maskLayer.path = path;
    self.overlayView.layer.mask = maskLayer;
    CGPathRelease(path);
}

/**
 * @brief  添加缩放手势 和 拖动手势
 *
 * @param
 *
 * @return
 */
- (void)addGestureRecognizers
{
    // 添加缩放手势
    UIPinchGestureRecognizer * pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
    [self.view addGestureRecognizer:pinch];
    
    // 添加拖动手势
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:pan];
}

/**
 * @brief  缩放手势事件
 *
 * @param
 *
 * @return
 */
- (void)pinchAction:(UIPinchGestureRecognizer *)pinch
{
    UIView * view = self.showImageView;
    if (pinch.state == UIGestureRecognizerStateBegan || pinch.state == UIGestureRecognizerStateChanged) {
        // 通过手势的缩放系数改变view的transform
        view.transform = CGAffineTransformScale(view.transform, pinch.scale, pinch.scale);
        // 然后将缩放系数置为1
        pinch.scale = 1.0f;
    }else if (pinch.state == UIGestureRecognizerStateEnded) {
        // 缩放结束
        CGRect newFrame = self.showImageView.frame;
        newFrame = [self hanleScaleOverFrame:newFrame];
        newFrame = [self handleBorderOverFlow:newFrame];
        
        [UIView animateWithDuration:Boundce_Duration animations:^{
            self.showImageView.frame = newFrame;
            self.lastFrame = newFrame;
        }];
    }
}

/**
 * @brief  计算缩放后的新的frame
 *
 * @param
 *
 * @return
 */
- (CGRect)hanleScaleOverFrame:(CGRect)newFrame
{
    CGPoint oriCenter = CGPointMake(newFrame.origin.x + newFrame.size.width / 2.0f, newFrame.origin.y + newFrame.size.height / 2.0f);
    if (newFrame.size.width < self.oldFrame.size.width) {
        // 设置原始frame
        newFrame = self.oldFrame;
    }
    
    if (newFrame.size.width > self.largeFrame.size.width) {
        // 超出范围
        newFrame = self.largeFrame;
    }
    
    newFrame.origin.x = oriCenter.x - newFrame.size.width / 2.0f;
    newFrame.origin.y = oriCenter.y - newFrame.size.height / 2.0f;
    
    return newFrame;
}

/**
 * @brief  根据边框来设置frame
 *
 * @param
 *
 * @return
 */
- (CGRect)handleBorderOverFlow:(CGRect)newFrame
{
    // x坐标 计算不能超过裁剪的坐标x
    if (newFrame.origin.x > self.cropFrame.origin.x) {
        newFrame.origin.x = self.cropFrame.origin.x;
    }
    
    if (CGRectGetMaxX(newFrame) < self.cropFrame.size.width) {
        newFrame.origin.x = self.cropFrame.size.width - newFrame.size.width;
    }
    
    // y坐标
    if (newFrame.origin.y > self.cropFrame.origin.y) {
        newFrame.origin.y = self.cropFrame.origin.y;
    }
    
    if (CGRectGetMaxY(newFrame) < self.cropFrame.origin.y + self.cropFrame.size.height) {
        newFrame.origin.y = self.cropFrame.origin.y + self.cropFrame.size.height - newFrame.size.height;
    }
    
    if (self.showImageView.frame.size.width > self.showImageView.frame.size.height && newFrame.size.height <= self.cropFrame.size.height) {
        newFrame.origin.y = self.cropFrame.origin.y + (self.cropFrame.size.height - newFrame.size.height) / 2.0f;
    }
    
    return newFrame;
}

/**
 * @brief  拖动手势
 *
 * @param
 *
 * @return
 */
- (void)panAction:(UIPanGestureRecognizer *)pan
{
    UIView * view = self.showImageView;
    
    if (pan.state == UIGestureRecognizerStateBegan || pan.state == UIGestureRecognizerStateChanged) {
        CGFloat absCenterX = self.cropFrame.origin.x + self.cropFrame.size.width / 2.0f;
        CGFloat absCenterY = self.cropFrame.origin.y + self.cropFrame.size.height / 2.0f;
        
        CGFloat scaleRatio = self.showImageView.frame.size.width / self.cropFrame.size.width;
        CGFloat acceleratorX = 1 - ABS(absCenterX - view.center.x) / (scaleRatio * absCenterX);
        CGFloat acceleratorY = 1 - ABS(absCenterY - view.center.y) / (scaleRatio * absCenterY);
        CGPoint translation = [pan translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x * acceleratorX, view.center.y + translation.y * acceleratorY}];
        [pan setTranslation:CGPointZero inView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x * acceleratorX, view.center.y + translation.y * acceleratorY}];
        [pan setTranslation:CGPointZero inView:view.superview];
    }else if (pan.state == UIGestureRecognizerStateEnded){
        CGRect newFrame = self.showImageView.frame;
        newFrame = [self handleBorderOverFlow:newFrame];
        [UIView animateWithDuration:Boundce_Duration animations:^{
            self.showImageView.frame = newFrame;
            self.lastFrame           = newFrame;
        }];
    }
}

// 得到裁剪后的小图片
-(UIImage *)getSubImage{
    CGRect squareFrame = self.cropFrame;
    CGFloat scaleRatio = self.lastFrame.size.width / self.orignalImage.size.width;
    CGFloat x = (squareFrame.origin.x - self.lastFrame.origin.x) / scaleRatio;
    CGFloat y = (squareFrame.origin.y - self.lastFrame.origin.y) / scaleRatio;
    CGFloat w = squareFrame.size.width / scaleRatio;
    CGFloat h = squareFrame.size.width / scaleRatio;
    if (self.lastFrame.size.width < self.cropFrame.size.width) {
        CGFloat newW = self.orignalImage.size.width;
        CGFloat newH = newW * (self.cropFrame.size.height / self.cropFrame.size.width);
        x = 0; y = y + (h - newH) / 2;
        w = newH; h = newH;
    }
    if (self.lastFrame.size.height < self.cropFrame.size.height) {
        CGFloat newH = self.orignalImage.size.height;
        CGFloat newW = newH * (self.cropFrame.size.width / self.cropFrame.size.height);
        x = x + (w - newW) / 2; y = 0;
        w = newH; h = newH;
    }
    CGRect myImageRect = CGRectMake(x, y, w, h);
    CGImageRef imageRef = self.orignalImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
    CGSize size;
    size.width = myImageRect.size.width;
    size.height = myImageRect.size.height;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myImageRect, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(subImageRef);
    
    return smallImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialView];
    [self initControlBtn];
}

@end
