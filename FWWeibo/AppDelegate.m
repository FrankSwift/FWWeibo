//
//  AppDelegate.m
//  FWWeibo
//
//  Created by 沈方伟 on 16/1/18.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "AppDelegate.h"
#import "FWControllerTool.h"
#import "FWOAuthViewController.h"
#import "FWAccountTool.h"
#import "FWAccount.h"
#import "SDWebImageManager.h"
#import "SDImageCache.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import <JSPatch/JSPatch.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [JSPatch setupLogger:^(NSString *msg) {
        FWLog(@"%@",msg);
    }];
    
    [JSPatch startWithAppKey:@"appkey"];
    [JSPatch sync];
    // 1.创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 2. 显示窗口(成为主窗口)
    [self.window makeKeyAndVisible];
    
    // 3.设置窗口控制器
    
    FWAccount *account = [FWAccountTool account];
    
    if (account) {
        [FWControllerTool chooseRootViewController];
    }else{
        self.window.rootViewController = [[FWOAuthViewController alloc] init];
    }

    // 4.监听网络状况
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 一定网络发生变化就调用次方法
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            case AFNetworkReachabilityStatusNotReachable:
                [MBProgressHUD showError:@"网络不可用,请检查网络设置!"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                FWLog(@"WWAN");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                FWLog(@"WiFi");
                break;
        }
    }];
    //开始监听
    [mgr startMonitoring];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
   UIBackgroundTaskIdentifier tID =  [application beginBackgroundTaskWithExpirationHandler:^{
       [application endBackgroundTask:tID];
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    
    //清除所有的内存缓存
    [[SDImageCache sharedImageCache] clearMemory];
    
    // 赶紧停止正在进行的图片下载操作
    [[SDWebImageManager sharedManager] cancelAll];
}
@end
