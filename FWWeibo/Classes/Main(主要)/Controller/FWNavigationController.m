//
//  FWNavigationController.m
//  FWWeibo
//
//  Created by travelzen on 16/1/20.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWNavigationController.h"

@interface FWNavigationController ()

@end

@implementation FWNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (void)initialize{
    // 设置UINavigationBarTheme的主题
    [self setupNavigationBarTheme];
    
    // 设置UIBarButtonItem的主题
    [self setupBarButtonItemTheme];
}

/**
 *  设置UINavigationBarTheme的主题
 */
+ (void)setupNavigationBarTheme{
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    [appearance setTitleTextAttributes:@{NSFontAttributeName : KNavigationTitleFont}];
}

/**
 *  设置UIBarButtonItem的主题
 */
+ (void)setupBarButtonItemTheme{
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    //普通状态
    [appearance setTitleTextAttributes:@{NSFontAttributeName : KFont(15),
                                         NSForegroundColorAttributeName: KColor(orangeColor)
                                         } forState:UIControlStateNormal];
    //高亮状态
    [appearance setTitleTextAttributes:@{NSFontAttributeName : KFont(15),NSForegroundColorAttributeName: KColor(redColor)} forState:UIControlStateHighlighted];
    //不可用状态
    [appearance setTitleTextAttributes:@{NSFontAttributeName : KFont(15),
                                         NSForegroundColorAttributeName: KColor(lightGrayColor)} forState:UIControlStateDisabled];
    /**设置背景**/
    // 技巧: 为了让某个按钮的背景消失, 可以设置一张完全透明的背景图片
    [appearance setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        // 设置导航栏按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_back" selectedImage:@"navigationbar_back_highlighted" target:self action:@selector(back)];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_more" selectedImage:@"navigationbar_more_highlighted" target:self action:@selector(more)];
    }
    [super pushViewController:viewController animated:animated];
}


- (void)back
{

    [self popViewControllerAnimated:YES];
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}
@end
