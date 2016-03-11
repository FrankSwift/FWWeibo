//
//  FWLoadMoreFooter.h
//  FWWeibo
//
//  Created by travelzen on 16/2/16.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FWLoadMoreFooter : UIView

/** 是否刷新 */
@property (nonatomic, assign, getter=isRefreshing) BOOL refreshing;

+ (instancetype)footer;
- (void)beginRefreshing;
- (void)endRefreshing;
@end
