//
//  FWHomeStatusesResult.h
//  FWWeibo
//
//  Created by travelzen on 16/2/17.
//  Copyright © 2016年 FrankShen. All rights reserved.
//  封装加载首页微博数据的返回结果

#import <Foundation/Foundation.h>

@interface FWHomeStatusesResult : NSObject
/** 微博数组(装着FWStatus模型) */
@property (nonatomic, copy) NSArray *statuses;

/** 微博数组(装着FWStatus模型) */
@property (nonatomic, assign) int total_number;

@end
