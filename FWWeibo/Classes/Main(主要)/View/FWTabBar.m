//
//  FWTabBar.m
//  FWWeibo
//
//  Created by travelzen on 16/1/29.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWTabBar.h"

@interface FWTabBar ()
@property (nonatomic, weak) UIButton *plusButton;
@end
@implementation FWTabBar

- (instancetype)initWithBlock:(void (^)())block{
    if (self = [super init]) {
        _tabBarBlock = block;
      
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        if (!IOS7) {
            self.backgroundImage = [UIImage imageWithName:@"tabbar_background"];
        }
        self.selectionIndicatorImage = [UIImage imageWithName:@"navigationbar_button_background"];
        //添加+按钮
        [self setupPlusButton];
    }
    
    return self;
}

/**
 *  添加+按钮
 */
- (void)setupPlusButton{
    UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    
    [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    [plusButton addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:plusButton];
    self.plusButton = plusButton;
}

/**
 *  点击了+按钮
 */
- (void)plusClick{

    !self.tabBarBlock ?: self.tabBarBlock();

}

- (void)layoutSubviews {
    [super layoutSubviews];
     
    //设置+按钮的frame
    [self setupPlusButtonFrame];
    
    //设置所有tabBarButton的frame
    [self setupAllTabBarButtonFrame];
    
}

/**
 *  设置+按钮的frame
 */
- (void)setupPlusButtonFrame{
    self.plusButton.size = self.plusButton.currentBackgroundImage.size;
    self.plusButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);
}

/**
 *  设置所有tabBarButton的frame
 */
- (void)setupAllTabBarButtonFrame{
    int index = 0;
    CGFloat btnW = self.width / (self.items.count + 1);
    CGFloat btnH = self.height -1;
    
    for (UIView *view in self.subviews) {
        if (! [view isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        view.width = btnW;
        view.height = btnH;
        view.y = 1;
        if (index >= 2) {
            view.x = btnW * (index +1);
        }else{
            view.x = btnW * index;
        }
        index ++;
    }
    
   
  
}
@end
