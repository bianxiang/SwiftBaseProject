//
//  ShowIntroHelper.m
//  LoveDaBai
//
//  Created by Jelly Foo on 16/3/16.
//  Copyright © 2016年 life. All rights reserved.
//

#import "ShowIntroHelper.h"
//#import "StyledPageControl.h"
#define appD [UIApplication sharedApplication].delegate
@interface ShowIntroHelper () <EAIntroDelegate>

@end

@implementation ShowIntroHelper

// 显示引导页
- (void)showIntro {
    NSNumber *launchInfo = [[NSUserDefaults standardUserDefaults] objectForKey:LaunchPage_Dismiss];
    NSString *versionNum = [[NSUserDefaults standardUserDefaults] objectForKey:Last_APP_VersionNum];
    
    if (!launchInfo || [launchInfo boolValue] == NO || !versionNum || [APP_Version integerValue] > [versionNum integerValue]) {
        [self showIntroWithCustomView];
    }
}

- (void)showIntroWithCustomView {
    EAIntroPage *page1 = [EAIntroPage page];
    EAIntroPage *page2 = [EAIntroPage page];
    EAIntroPage *page3 = [EAIntroPage page];
    
    // 默认用6的尺寸
    page1.bgImage = [UIImage imageNamed:@"launch6-1"];
    page2.bgImage = [UIImage imageNamed:@"launch6-2"];
    page3.bgImage = [UIImage imageNamed:@"launch6-3"];
    
    if (iPhone4) {// 4
//        page1.bgImage = [UIImage imageNamed:@"launch4-1"];
//        page2.bgImage = [UIImage imageNamed:@"launch4-2"];
//        page3.bgImage = [UIImage imageNamed:@"launch4-3"];
    } else if (iPhone5) { // 5
        page1.bgImage = [UIImage imageNamed:@"launch5-1.jpg"];
        page2.bgImage = [UIImage imageNamed:@"launch5-2.jpg"];
        page3.bgImage = [UIImage imageNamed:@"launch5-3.jpg"];
    } else if (iPhone6) { // 6
        page1.bgImage = [UIImage imageNamed:@"launch6-1.jpg"];
        page2.bgImage = [UIImage imageNamed:@"launch6-2.jpg"];
        page3.bgImage = [UIImage imageNamed:@"launch6-3.jpg"];
    }else if (iPhone6Plus) { // 6+
        page1.bgImage = [UIImage imageNamed:@"launch6plus-1"];
        page2.bgImage = [UIImage imageNamed:@"launch6plus-2"];
        page3.bgImage = [UIImage imageNamed:@"launch6plus-3"];
    }
    
//    UIColor *e4e4e4Color = K_UIColorFromRGB(0xe4e4e4);
//    UIColor *m15f08dColor = K_UIColorFromRGB(0x15f08d);
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:appD.window.bounds andPages:@[page1,page2,page3]];
    intro.swipeToExit = YES;
    
    intro.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:49/255.0 green:161/255.0 blue:229/255.0 alpha:1];
    intro.pageControl.pageIndicatorTintColor = [UIColor colorWithRed:150/255.0 green:140/255.0 blue:142/255.0 alpha:1];
//    intro.pageControl = pageControl;
    intro.pageControlY = 38;
//    intro.pageControl.frame = CGRectMake(0, intro.pageControl.origin.y, 2*intro.pageControl.frame.size.width, 2*intro.pageControl.frame.size.height);
    
    
    UIButton *experienceBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [experienceBtn setFrame:CGRectMake(0, 0, 120, 55)];
//    [experienceBtn setTitle:@"开始体验" forState:UIControlStateNormal];
    [experienceBtn setBackgroundImage:[UIImage imageNamed:@"experienceBtn"] forState:UIControlStateNormal];
//    [experienceBtn setTitleColor:[UIColor colorWithRed:49/255.0 green:161/255.0 blue:229/255.0 alpha:1] forState:UIControlStateNormal];
//    experienceBtn.layer.borderWidth = 1.f;
//    experienceBtn.layer.cornerRadius = 4;
//    experienceBtn.layer.borderColor = [UIColor colorWithRed:49/255.0 green:161/255.0 blue:229/255.0 alpha:1].CGColor;
    
    intro.skipButton = experienceBtn;
    
    intro.skipButtonY = 120.f;
    intro.skipButtonSideMargin = 0.f;
    intro.showSkipButtonOnlyOnLastPage = YES;
//    intro.skipButtonAlignment = EAViewAlignmentRight;
    
    [intro setDelegate:(id)appD];
    [intro showInView:appD.window animateDuration:0.3];
}

@end
