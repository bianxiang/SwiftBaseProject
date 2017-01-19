//
//  ShowIntroHelper.h
//  LoveDaBai
//
//  Created by Jelly Foo on 16/3/16.
//  Copyright © 2016年 life. All rights reserved.
//




#import <Foundation/Foundation.h>
#import "EAIntroView.h"
//判断iphone4
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 640), [[UIScreen mainScreen] currentMode].size) : NO)

//判断iphone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//判断iphone6
#define iPhone6 (667 == [[UIScreen mainScreen] bounds].size.height ? YES : NO)

//判断iphone6+
#define iPhone6Plus (736 == [[UIScreen mainScreen] bounds].size.height ? YES : NO)


// 引导页
#define LaunchPage_Dismiss @"LaunchPage_Dismiss"
// 存储上一次的app version num
#define Last_APP_VersionNum @"Last_APP_VersionNum"

#define APP_Version [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

@interface ShowIntroHelper : NSObject

/**
 *  显示引导页
 */
- (void)showIntro;

@end
