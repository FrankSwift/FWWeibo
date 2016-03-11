//
//  FWTabBar.h
//  FWWeibo
//
//  Created by travelzen on 16/1/29.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FWTabBar : UITabBar

/** plusClick回调 */
@property (nonatomic, copy) void(^tabBarBlock)();

- (instancetype)initWithBlock:(void(^)())block;

@end
