//
//  AppDelegate.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/5/28.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>

//正式
static NSString *appKey = @"1bbfa385394d1e53218bdf75";
static NSString *channel = @"App Store";
static BOOL isProduction = 1;
//测试
//static BOOL isProduction = 0;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end
