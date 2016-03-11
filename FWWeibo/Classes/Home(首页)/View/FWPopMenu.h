//
//  FWPopMenu.h
//  FWWeibo
//
//  Created by travelzen on 16/2/5.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    FWPopMenuArrowDirectionMiddle,
    FWPopMenuArrowDirectionLeft,
    FWPopMenuArrowDirectionRight
}FWPopMenuArrowDirection;


@interface FWPopMenu : UIView

/** 回调 */
@property (nonatomic, copy) void(^block)();
/** 箭头方向 */
@property (nonatomic, assign) FWPopMenuArrowDirection direction;

/** <#Description#> */
@property (nonatomic, assign, getter = isDimBackground) BOOL dimBackground;
- (instancetype)initWithContentView:(UIView *)contentView block:(void(^)())block;
+ (instancetype)popMenuWithContentView:(UIView *)contentView block:(void(^)())block;

/**
 *  显示菜单
 */
- (void)showInRect:(CGRect)frame;

/**
 *  关闭菜单
 */
- (void)dismiss;
@end
