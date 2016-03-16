//
//  FWTabBarViewController.m
//  FWWeibo
//
//  Created by 沈方伟 on 16/1/19.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWTabBarViewController.h"
#import "FWHomeViewController.h"
#import "FWDiscoverViewController.h"
#import "FWMessageViewController.h"
#import "FWProfileViewController.h"
#import "FWTabBar.h"
#import "FWComposeViewController.h"
#import "FWUserTool.h"
#import "FWUnreadParam.h"
#import "FWAccount.h"
#import "FWAccountTool.h"

@interface FWTabBarViewController ()<UITabBarControllerDelegate>

/** 首页控制器 */
@property(nonatomic, weak) FWHomeViewController *homeVC;

/** 消息控制器 */
@property(nonatomic, weak) FWMessageViewController *messageVC;

/** 发现控制器 */
@property(nonatomic, weak) FWDiscoverViewController *discoverVC;

/** 我控制器 */
@property(nonatomic, weak) FWProfileViewController *profileVC;

/** 上一回选中的控制器 */
@property(nonatomic, weak) UIViewController *lastSelectedVC;
@end

@implementation FWTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加子控制器
    [self setupVC];
    
    //设置Tabbar
    [self setupTabBar];
    
    self.delegate = self;
    
    // 获取某个用户的各种消息未读数
    NSTimer *timer= [NSTimer scheduledTimerWithTimeInterval:30.0f target:self selector:@selector(getUnreadInfo) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}


#pragma mark - 数据
#pragma mark 获取某个用户的各种消息未读数
- (void)getUnreadInfo{
    FWUnreadParam *param = [[FWUnreadParam alloc] init];
    param.uid = [FWAccountTool account].uid;
    
    [FWUserTool unreadWithParam:param success:^(FWUnreadResult *result) {
        
        if(IOS8){
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        }
        if (result.status == 0) {
            self.homeVC.tabBarItem.badgeValue = nil;
        } else {
            self.homeVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        }
        
        // 显示消息未读数
        if (result.messageCount == 0) {
            self.messageVC.tabBarItem.badgeValue = nil;
        } else {
            self.messageVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageCount];
        }
        
        // 显示新粉丝数
        if (result.follower == 0) {
            self.profileVC.tabBarItem.badgeValue = nil;
        } else {
            self.profileVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
        }
        
        // 在图标上显示所有的未读数
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;
        
    } failure:^(NSError *error) {
        FWLog(@"获取某个用户的各种消息未读数失败:%@",error);
    }];
    
}
#pragma mark - 逻辑
/**
 *  设置Tabbar
 */
- (void)setupTabBar{
    __weak typeof(self) weakSelf = self;

    FWTabBar *tabBar = [[FWTabBar alloc] initWithBlock:^{
        FWComposeViewController *composeVC = [[FWComposeViewController alloc] init];
        FWNavigationController *nav = [[FWNavigationController alloc] initWithRootViewController:composeVC];
        [weakSelf presentViewController:nav animated:YES completion:nil];
    }];

    [self setValue:tabBar forKeyPath:@"tabBar"];
    
}

/**
 *  添加子控制器
 */
- (void)setupVC{
    FWHomeViewController *homeVC = [[FWHomeViewController alloc] init];
    [self addChildVC:homeVC title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    self.homeVC = homeVC;
    
    FWMessageViewController *messageVC = [[FWMessageViewController alloc] init];
    [self addChildVC:messageVC title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    self.messageVC = messageVC;
    
    FWDiscoverViewController *discoverVC = [[FWDiscoverViewController alloc] init];
    [self addChildVC:discoverVC title:@"发现" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    self.discoverVC = discoverVC;
    
    FWProfileViewController *profileVC = [[FWProfileViewController alloc] init];
    [self addChildVC:profileVC title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    self.profileVC = profileVC;
}

/**
 *  添加子控制器
 *
 *  @param childVC           自控制器
 *  @param title             标题
 *  @param imageName         图片
 *  @param selectedImageName 选中图片
 */
- (void)addChildVC:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
//    childVC.view.backgroundColor = FWRandomColor;
    
    childVC.title = title;
    [childVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: KColor(lightGrayColor),
                                                 NSFontAttributeName :KFont(10)} forState:UIControlStateNormal];
    [childVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: KColor(orangeColor),
                                                 NSFontAttributeName :KFont(10)} forState:UIControlStateSelected];
//    childVC.tabBarItem.badgeValue = @"10";
    
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    
    UIImage *selImg = [UIImage imageNamed:selectedImageName];
    if (IOS7) {
        selImg = [selImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    childVC.tabBarItem.selectedImage = selImg;
    
    FWNavigationController *nav = [[FWNavigationController alloc] initWithRootViewController:childVC];
    
    [self addChildViewController:nav];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(FWNavigationController *)viewController{
    UIViewController *vc = [viewController.viewControllers firstObject];

    if ([vc isKindOfClass:[FWHomeViewController class]]) {
        if (self.lastSelectedVC == vc) {
            [self.homeVC refresh:YES];
        }else{
            [self.homeVC refresh:NO];
        }
    }
    
    self.lastSelectedVC = vc;
    
}
@end
