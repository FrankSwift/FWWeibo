//
//  FWControllerTool.m
//  FWWeibo
//
//  Created by travelzen on 16/2/15.
//  Copyright © 2016年 FrankShen. All rights reserved.
//  负责控制器相关的操作

#import "FWControllerTool.h"
#import "FWNewfeatureViewController.h"
#import "FWTabBarViewController.h"

@implementation FWControllerTool

+ (void)chooseRootViewController{
    NSString *versionKey = @"CFBundleVersion";

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:versionKey];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    //获取当前的版本号
    NSString *currenVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    if (![lastVersion isEqualToString:currenVersion]) {
        window.rootViewController = [[FWNewfeatureViewController alloc] init];
        
        //存储这次使用的软件版本
        [defaults setObject:currenVersion forKey:versionKey];
        [defaults synchronize];
    }else{
        [UIApplication sharedApplication].statusBarHidden = NO;
        window.rootViewController = [[FWTabBarViewController alloc] init];
    }
}
@end
